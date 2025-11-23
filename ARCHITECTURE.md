# Firestore Collections Architecture
Role-Based + Stripe Subscription Support
The app uses a central `users` collection for identity and role.
Role-specific data lives in separate collections using the same `userId`.
The **employers** collection now includes Stripe subscription details updated via webhooks.
---
# 1. users (Main Identity Collection)
Collection: `users`
Document ID: Firebase Auth UID
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "phone": "+1234567890",
  "role": "seeker | employer | admin",
  "createdAt": 0
}
```
---
# 2. job_seekers
Collection: `job_seekers`
Document ID: userId
```json
{
  "userId": "uid",
  "city": "New York",
  "zip": "10001",
  "languages": ["English", "Spanish"],
  "certifications": ["CPR"],
  "preferences": {
    "categories": ["Hospitality"],
    "payRange": { "type": "hourly", "min": 15, "max": 20 },
    "availability": ["Day"],
    "startImmediately": true
  },
  "isProfileCompleted": true,
  "createdAt": 0
}
```
---
# 3. employers (With Stripe Subscription Info)
Collection: `employers`
Document ID: userId
### :fire: Includes:
- Stripe Customer ID
- Subscription ID
- Product/Price IDs
- Billing status
- Renewal date
- Interview credits
- Last webhook sync
---
## employers/{userId} Fields
```json
{
  "userId": "uid",
  "companyName": "Acme Corp",
  "ein": "12-3456789",
  "industry": "Hospitality",
  "companySize": "11-50",
  "address": {
    "city": "New York",
    "state": "NY",
    "zip": "10001"
  },
  "website": "https://acme.com",
  "logoUrl": "https://...",
  "subscription": {
    "plan": "flex | starter | pro | enterprise",
    "stripeCustomerId": "cus_123456789",
    "stripeSubscriptionId": "sub_1234567",
    "stripePriceId": "price_ABC123",
    "status": "active | trialing | past_due | canceled | unpaid",
    "currentPeriodStart": 1700000000,
    "currentPeriodEnd": 1700020000,
    "cancelAtPeriodEnd": false,
    "interval": "month",
    "trialEnd": null
  },
  "interviewCredits": 50,
  "lastWebhookUpdate": 1700000000,
  "createdAt": 0
}
```
---
# :wrench: Stripe Webhook Fields Explained
### `stripeCustomerId`
Created during:
- Registration
- Or first subscription checkout
### `stripeSubscriptionId`
Created when user subscribes to a plan.
### `stripePriceId`
Identifies which pricing tier they selected.
### `status`
Updated via webhooks:
- `customer.subscription.created`
- `customer.subscription.updated`
- `customer.subscription.deleted`
### `currentPeriodStart / currentPeriodEnd`
Used to show renewal date in employer dashboard.
### `interviewCredits`
Updated by webhook or Cloud Function when:
- Subscription activates
- Renewal happens
- Add-on credits purchased
### `lastWebhookUpdate`
Used to detect stale billing data or webhook failures.
---
# :memo: Optional: Webhook Logs Collection (recommended)
```
subscription_logs/{logId}
```
```json
{
  "employerId": "uid",
  "eventId": "evt_123",
  "type": "customer.subscription.updated",
  "data": {},
  "timestamp": 1700000000
}
```
This helps debug billing issues and prevents double-processing.
# 3. jobs
Collection: `jobs`

## Document ID
`jobId` (auto ID)

## Fields
```json
{
  "employerId": "uid",
  "jobTitle": "Line Cook",
  "category": "Hospitality",
  "payRange": {
    "type": "hourly",
    "min": 18,
    "max": 22
  },
  "location": {
    "city": "New York",
    "zip": "10001"
  },
  "schedule": ["Day", "Evening"],
  "availability": ["Weekends", "Overtime"],
  "startDate": 1700000000,
  "description": "Job description here",
  "preQualificationQuestions": [
    {
      "id": "q1",
      "question": "Do you have 1 year experience?",
      "type": "yes_no",
      "isDealBreaker": false
    }
  ],
  "interviewWindows": [
    {
      "date": "23.11.2025",
      "start": "09:00",
      "end": "13:00"
    }
  ],
  "status": "active | paused | deleted",
  "createdAt": 0
}
```

---

# 4. queues  
Collection: `queues`  
Each job has its own queue.

## Path
`queues/{jobId}/users/{seekerId}`

## Fields
```json
{
  "userId": "seekerUid",
  "jobId": "jobId",
  "joinedAt": 1700000000,
  "status": "waiting | interviewing | done",
  "answers": {
    "q1": "Yes",
    "q2": "I have 3 years experience"
  },
  "position": 5,
  "updatedAt": 0
}
```

---

# 5. outcomes
Interview outcomes saved for history.

## Path
`outcomes/{jobId}_{seekerId}`

## Fields
```json
{
  "jobId": "jobId",
  "seekerId": "uid",
  "employerId": "uid",
  "outcome": "hire | follow_up | not_fit",
  "notes": "Candidate was great",
  "createdAt": 0,
  "contactUnlocked": true
}
```

---

# 6. subscriptions
Collection: `subscriptions`

## Document ID
`employerId`

## Fields
```json
{
  "plan": "starter",
  "stripeCustomerId": "cus_123",
  "paymentStatus": "active | past_due",
  "renewalDate": 1700000000,
  "interviewCredits": 50,
  "createdAt": 0,
  "updatedAt": 0
}
```

---

# 7. flags (Moderation System)
Collection: `flags`

## Document ID
`flagId`

```json
{
  "type": "job | user | employer",
  "targetId": "jobId or userId",
  "reportedBy": "uid",
  "reason": "Inappropriate job posting",
  "details": "Description",
  "status": "pending | reviewed | dismissed",
  "createdAt": 0
}
```

---

# 8. settings (Global Config)
Collection: `settings`

### Documents
- `categories`
- `payRanges`
- `languages`
- `certifications`
- `prequalTemplates`

Example:

```
settings/categories
```

```json
{
  "values": ["Hospitality", "Retail", "Construction"]
}
```

---

# 9. support_tickets
Path: `support_tickets/{ticketId}`

```json
{
  "userId": "uid",
  "message": "I can't join interview",
  "email": "user@example.com",
  "status": "open | resolved",
  "createdAt": 0,
  "updatedAt": 0
}
```

---

# 10. admin_logs
For audits and moderation.

```
admin_logs/{logId}
```

```json
{
  "adminId": "uid",
  "action": "delete_job",
  "targetId": "jobId",
  "timestamp": 0,
  "details": "Removed spam job posting"
}
```
