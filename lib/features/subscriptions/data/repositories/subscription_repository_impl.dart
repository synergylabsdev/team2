import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team2/core/constants/subscription_constants.dart';

/// Subscription repository implementation
class SubscriptionRepository {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    // For now, add-ons can be handled similarly
    // You may want to create separate product IDs for add-ons
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User must be authenticated');
    }

    final callable = _functions.httpsCallable('createAddOnCheckoutSession');
    final result = await callable.call({
      'userId': user.uid,
      'addOnType': addOnType,
      'email': user.email,
    });

    final checkoutUrl = result.data['url'] as String?;
    if (checkoutUrl == null) {
      throw Exception('Failed to create add-on checkout session');
    }

    return checkoutUrl;
  }
}
