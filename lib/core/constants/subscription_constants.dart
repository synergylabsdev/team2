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

  /// Get product ID for a plan type
  static String? getProductId(String planType) {
    return planToProductId[planType.toLowerCase()];
  }
}

