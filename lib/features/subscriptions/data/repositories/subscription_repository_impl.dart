import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team2/core/constants/subscription_constants.dart';

/// Subscription repository implementation
class SubscriptionRepository {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Create a Stripe checkout session for a subscription plan
  /// This calls a Cloud Function that creates the checkout session server-side
  /// Returns the checkout session URL
  Future<String> createCheckoutSession({
    required String productId,
    required String planType,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User must be authenticated to create checkout session');
      }

      final callable = _functions.httpsCallable('createCheckoutSession');
      final result = await callable.call({
        'userId': user.uid,
        'productId': productId,
        'planType': planType,
        'email': user.email,
      });

      final checkoutUrl = result.data['url'] as String?;
      if (checkoutUrl == null) {
        throw Exception('Failed to create checkout session');
      }

      return checkoutUrl;
    } catch (e) {
      throw Exception('Error creating checkout session: $e');
    }
  }

  /// Create checkout session for a plan by plan type
  Future<String> createPlanCheckoutSession(String planType) async {
    final productId = SubscriptionConstants.getProductId(planType);
    if (productId == null) {
      throw Exception('Invalid plan type: $planType');
    }

    return createCheckoutSession(
      productId: productId,
      planType: planType,
    );
  }

  /// Create checkout session for an add-on
  Future<String> createAddOnCheckoutSession(String addOnType) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User must be authenticated');
    }

    // Get add-on details to pass to Cloud Function
    final addOnDetails = SubscriptionConstants.getAddOnDetails(addOnType);
    if (addOnDetails == null) {
      throw Exception('Invalid add-on type: $addOnType');
    }

    final callable = _functions.httpsCallable('createAddOnCheckoutSession');
    final result = await callable.call({
      'userId': user.uid,
      'addOnType': addOnType,
      'email': user.email,
      'jobPostings': addOnDetails.jobPostings,
      'interviewCredits': addOnDetails.interviewCredits,
    });

    final checkoutUrl = result.data['url'] as String?;
    if (checkoutUrl == null) {
      throw Exception('Failed to create add-on checkout session');
    }

    return checkoutUrl;
  }

  /// Update employer credits after add-on payment (called by webhook or manually)
  /// This should ideally be handled by the webhook, but can be called for verification
  Future<void> updateEmployerCredits({
    required String userId,
    required int jobPostings,
    required int interviewCredits,
  }) async {
    try {
      final employerRef = _firestore.collection('employers').doc(userId);
      
      // Use transaction to safely increment values
      await _firestore.runTransaction((transaction) async {
        final doc = await transaction.get(employerRef);
        
        if (!doc.exists) {
          throw Exception('Employer document not found');
        }

        final currentJobPostings = (doc.data()?['jobPostingSlots'] as int?) ?? 0;
        final currentInterviewCredits = (doc.data()?['interviewCredits'] as int?) ?? 0;

        transaction.update(employerRef, {
          'jobPostingSlots': currentJobPostings + jobPostings,
          'interviewCredits': currentInterviewCredits + interviewCredits,
          'lastWebhookUpdate': FieldValue.serverTimestamp(),
        });
      });
    } catch (e) {
      throw Exception('Failed to update employer credits: $e');
    }
  }

  /// Mock subscription purchase - simulates successful subscription without Stripe
  /// Updates Firestore directly for testing purposes
  Future<void> mockPurchasePlan(String planType) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User must be authenticated');
      }

      // Get plan details
      final planDetails = _getPlanDetails(planType);
      
      final employerRef = _firestore.collection('employers').doc(user.uid);
      final now = DateTime.now();
      final periodEnd = now.add(const Duration(days: 30)); // 30 days for monthly plans

      // Update employer document with subscription info
      await employerRef.set({
        'subscription': {
          'plan': planType,
          'status': 'active',
          'currentPeriodStart': Timestamp.fromDate(now),
          'currentPeriodEnd': Timestamp.fromDate(periodEnd),
          'interval': 'month',
        },
        'interviewCredits': planDetails['interviewCredits'],
        'jobPostingSlots': planDetails['jobPostings'],
        'lastWebhookUpdate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to process subscription: $e');
    }
  }

  /// Mock add-on purchase - simulates successful add-on purchase without Stripe
  Future<void> mockPurchaseAddOn(String addOnType) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User must be authenticated');
      }

      final addOnDetails = SubscriptionConstants.getAddOnDetails(addOnType);
      if (addOnDetails == null) {
        throw Exception('Invalid add-on type: $addOnType');
      }

      await updateEmployerCredits(
        userId: user.uid,
        jobPostings: addOnDetails.jobPostings,
        interviewCredits: addOnDetails.interviewCredits,
      );
    } catch (e) {
      throw Exception('Failed to process add-on: $e');
    }
  }

  /// Get plan details for mock purchase
  Map<String, int> _getPlanDetails(String planType) {
    switch (planType.toLowerCase()) {
      case 'flex':
        return {'interviewCredits': 10, 'jobPostings': 1};
      case 'starter':
        return {'interviewCredits': 50, 'jobPostings': 999}; // Unlimited
      case 'pro':
        return {'interviewCredits': 200, 'jobPostings': 999}; // Unlimited
      case 'enterprise':
        return {'interviewCredits': 9999, 'jobPostings': 999}; // Unlimited
      default:
        return {'interviewCredits': 0, 'jobPostings': 0};
    }
  }
}
