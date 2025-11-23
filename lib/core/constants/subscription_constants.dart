/// Subscription product IDs and constants
class SubscriptionConstants {
  SubscriptionConstants._();

  // Stripe Product IDs
  static const String flexProductId = 'prod_TTUn8Z0mjYF2j1';
  static const String starterProductId = 'prod_TTUp29U7pcYaGj';
  static const String proProductId = 'prod_TTUqAGbVaJnByU';
  static const String enterpriseProductId = 'prod_TTUryjER0fH4Y1';

  // Plan type mappings
  static const Map<String, String> planToProductId = {
    'flex': flexProductId,
    'starter': starterProductId,
    'pro': proProductId,
    'enterprise': enterpriseProductId,
  };

  // Add-on types and their increments
  static const Map<String, AddOnDetails> addOnDetails = {
    'extra_job_posting': AddOnDetails(
      jobPostings: 1,
      interviewCredits: 0,
    ),
    'extra_interview_bundle': AddOnDetails(
      jobPostings: 0,
      interviewCredits: 10,
    ),
    'priority_queue_boost': AddOnDetails(
      jobPostings: 0,
      interviewCredits: 0,
      // This is a monthly subscription, handled differently
    ),
  };

  /// Get product ID for a plan type
  static String? getProductId(String planType) {
    return planToProductId[planType.toLowerCase()];
  }

  /// Get add-on details
  static AddOnDetails? getAddOnDetails(String addOnType) {
    return addOnDetails[addOnType.toLowerCase()];
  }
}

/// Add-on details including increments for job postings and interview credits
class AddOnDetails {
  final int jobPostings;
  final int interviewCredits;

  const AddOnDetails({
    required this.jobPostings,
    required this.interviewCredits,
  });
}

