# Stripe Subscription Setup Guide

## Overview
The subscription functionality is now integrated with Stripe. This guide explains how to set up the backend Cloud Function to complete the integration.

## What's Already Implemented

### Frontend (Flutter)
- Γ£à Stripe configuration with publishable key
- Γ£à Subscription constants with product IDs
- Γ£à Subscription repository to call Cloud Functions
- Γ£à Subscription cubit to handle checkout flow
- Γ£à UI integration in subscription page

### Product IDs Configured
- **Flex**: `prod_TTUn8Z0mjYF2j1`
- **Starter**: `prod_TTUp29U7pcYaGj`
- **Pro**: `prod_TTUqAGbVaJnByU`
- **Enterprise**: `prod_TTUryjER0fH4Y1`

## Required: Firebase Cloud Function

You need to create a Firebase Cloud Function that creates Stripe checkout sessions. Here's the implementation:

### 1. Install Stripe in Cloud Functions

```bash
cd functions
npm install stripe
```

### 2. Create the Cloud Function

Create `functions/index.js`:

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const stripe = require('stripe')(functions.config().stripe.secret_key);

admin.initializeApp();

// Create checkout session for subscription plans
exports.createCheckoutSession = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated'
    );
  }

  const { userId, productId, planType, email } = data;

  try {
    // Get or create Stripe customer
    let customerId;
    const userDoc = await admin.firestore()
      .collection('employers')
      .doc(userId)
      .get();

    if (userDoc.exists && userDoc.data().subscription?.stripeCustomerId) {
      customerId = userDoc.data().subscription.stripeCustomerId;
    } else {
      // Create new Stripe customer
      const customer = await stripe.customers.create({
        email: email,
        metadata: {
          userId: userId,
        },
      });
      customerId = customer.id;

      // Save customer ID to Firestore
      await admin.firestore()
        .collection('employers')
        .doc(userId)
        .set({
          subscription: {
            stripeCustomerId: customerId,
          },
        }, { merge: true });
    }

    // Get the price ID for the product
    // You'll need to get the default price ID for each product
    const prices = await stripe.prices.list({
      product: productId,
      active: true,
    });

    if (prices.data.length === 0) {
      throw new Error(`No active price found for product ${productId}`);
    }

    const priceId = prices.data[0].id;

    // Create checkout session
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      payment_method_types: ['card'],
      mode: 'subscription',
      line_items: [
        {
          price: priceId,
          quantity: 1,
        },
      ],
      success_url: 'https://your-app.com/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://your-app.com/cancel',
      metadata: {
        userId: userId,
        planType: planType,
      },
    });

    return { url: session.url };
  } catch (error) {
    console.error('Error creating checkout session:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to create checkout session',
      error.message
    );
  }
});

// Create checkout session for add-ons (one-time payments)
exports.createAddOnCheckoutSession = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError(
      'unauthenticated',
      'User must be authenticated'
    );
  }

  const { userId, addOnType, email, jobPostings, interviewCredits } = data;

  try {
    // Get or create Stripe customer (similar to subscription flow)
    let customerId;
    const userDoc = await admin.firestore()
      .collection('employers')
      .doc(userId)
      .get();

    if (userDoc.exists && userDoc.data().subscription?.stripeCustomerId) {
      customerId = userDoc.data().subscription.stripeCustomerId;
    } else {
      const customer = await stripe.customers.create({
        email: email,
        metadata: { userId: userId },
      });
      customerId = customer.id;
      await admin.firestore()
        .collection('employers')
        .doc(userId)
        .set({
          subscription: { stripeCustomerId: customerId },
        }, { merge: true });
    }

    // Create checkout session for one-time payment
    // You'll need to create price IDs for add-ons in Stripe Dashboard
    const priceIds = {
      'extra_job_posting': 'price_extra_job_posting', // Replace with actual price ID
      'extra_interview_bundle': 'price_extra_interview_bundle', // Replace with actual price ID
      'priority_queue_boost': 'price_priority_queue_boost', // Replace with actual price ID
    };

    const priceId = priceIds[addOnType];
    if (!priceId) {
      throw new Error(`Invalid add-on type: ${addOnType}`);
    }

    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      payment_method_types: ['card'],
      mode: 'payment',
      line_items: [{ price: priceId, quantity: 1 }],
      success_url: 'https://your-app.com/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'https://your-app.com/cancel',
      metadata: {
        userId: userId,
        addOnType: addOnType,
        jobPostings: jobPostings.toString(),
        interviewCredits: interviewCredits.toString(),
      },
    });

    return { url: session.url };
  } catch (error) {
    console.error('Error creating add-on checkout session:', error);
    throw new functions.https.HttpsError(
      'internal',
      'Failed to create checkout session',
      error.message
    );
  }
});
```

### 3. Set Stripe Secret Key

```bash
firebase functions:config:set stripe.secret_key="YOUR_STRIPE_SECRET_KEY_HERE"
```

**Note:** Replace `YOUR_STRIPE_SECRET_KEY_HERE` with your actual Stripe secret key from the Stripe Dashboard.

### 4. Deploy the Function

```bash
firebase deploy --only functions
```

## Webhook Setup (Recommended)

You should also set up a webhook to handle subscription events:

1. Go to Stripe Dashboard ΓåÆ Webhooks
2. Add endpoint: `https://your-region-your-project.cloudfunctions.net/handleStripeWebhook`
3. Select events:
   - `customer.subscription.created`
   - `customer.subscription.updated`
   - `customer.subscription.deleted`
   - `checkout.session.completed`

4. Create the webhook handler in Cloud Functions:

```javascript
exports.handleStripeWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers['stripe-signature'];
  let event;

  try {
    event = stripe.webhooks.constructEvent(
      req.rawBody,
      sig,
      functions.config().stripe.webhook_secret
    );
  } catch (err) {
    return res.status(400).send(`Webhook Error: ${err.message}`);
  }

  // Handle the event
  switch (event.type) {
    case 'checkout.session.completed':
      const session = event.data.object;
      // Update Firestore with subscription info
      await admin.firestore()
        .collection('employers')
        .doc(session.metadata.userId)
        .update({
          'subscription.stripeSubscriptionId': session.subscription,
          'subscription.plan': session.metadata.planType,
          'subscription.status': 'active',
        });
      break;

    case 'customer.subscription.updated':
    case 'customer.subscription.deleted':
      const subscription = event.data.object;
      // Update subscription status in Firestore
      await admin.firestore()
        .collection('employers')
        .doc(subscription.metadata.userId)
        .update({
          'subscription.status': subscription.status,
          'subscription.currentPeriodEnd': subscription.current_period_end,
          'lastWebhookUpdate': admin.firestore.FieldValue.serverTimestamp(),
        });
      break;

    case 'checkout.session.completed':
      const session = event.data.object;
      const userId = session.metadata.userId;
      
      // Handle add-on purchases (one-time payments)
      if (session.mode === 'payment' && session.metadata.addOnType) {
        const jobPostings = parseInt(session.metadata.jobPostings || '0');
        const interviewCredits = parseInt(session.metadata.interviewCredits || '0');
        
        // Increment employer credits using transaction
        const employerRef = admin.firestore().collection('employers').doc(userId);
        await admin.firestore().runTransaction(async (transaction) => {
          const doc = await transaction.get(employerRef);
          if (doc.exists) {
            const currentJobPostings = (doc.data().jobPostingSlots || 0);
            const currentInterviewCredits = (doc.data().interviewCredits || 0);
            
            transaction.update(employerRef, {
              jobPostingSlots: currentJobPostings + jobPostings,
              interviewCredits: currentInterviewCredits + interviewCredits,
              lastWebhookUpdate: admin.firestore.FieldValue.serverTimestamp(),
            });
          }
        });
      }
      // Handle subscription purchases
      else if (session.mode === 'subscription' && session.metadata.planType) {
        await admin.firestore()
          .collection('employers')
          .doc(userId)
          .update({
            'subscription.stripeSubscriptionId': session.subscription,
            'subscription.plan': session.metadata.planType,
            'subscription.status': 'active',
            'lastWebhookUpdate': admin.firestore.FieldValue.serverTimestamp(),
          });
      }
      break;
  }

  res.json({ received: true });
});
```

## Testing

1. Use Stripe test cards: https://stripe.com/docs/testing
2. Test card: `4242 4242 4242 4242`
3. Any future expiry date and CVC

## Important Notes

- **Secret Key**: Never expose the secret key in client-side code. It's only used in Cloud Functions.
- **Publishable Key**: Already configured in `lib/core/config/stripe_config.dart`
- **Success/Cancel URLs**: Update these in the Cloud Function to match your app's deep linking setup
- **Webhooks**: Essential for keeping Firestore in sync with Stripe subscription status

## Next Steps

1. Deploy the Cloud Functions
2. Set up webhooks in Stripe Dashboard
3. Test the subscription flow
4. Configure deep linking for success/cancel URLs

