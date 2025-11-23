import 'package:flutter_stripe/flutter_stripe.dart';

/// Stripe configuration constants
class StripeConfig {
  StripeConfig._();

  // Stripe publishable key (test mode)
  static const String publishableKey =
      'pk_test_51RqG4uET4NAZpFjDiN1M0IeJ2oR2wt5HBnVJLXYfVCSzNwOzqHyWjZTASu1FoF4yAXFNmllkByIPbnoW6cm2JoKw00M8Vpat67';

  /// Initialize Stripe with publishable key
  static Future<void> initialize() async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }
}
