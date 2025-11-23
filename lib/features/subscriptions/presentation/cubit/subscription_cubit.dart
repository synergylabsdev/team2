import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:team2/features/subscriptions/data/repositories/subscription_repository_impl.dart';
import 'package:team2/features/subscriptions/presentation/cubit/subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository _repository = SubscriptionRepository();

  SubscriptionCubit() : super(const SubscriptionState());

  void toggleBillingType() {
    emit(state.copyWith(isMonthlyBilling: !state.isMonthlyBilling));
  }

  void setMonthlyBilling(bool isMonthly) {
    emit(state.copyWith(isMonthlyBilling: isMonthly));
  }

  Future<void> purchasePlan(String planType) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      // Create checkout session via Cloud Function
      final checkoutUrl = await _repository.createPlanCheckoutSession(planType);

      // Open Stripe Checkout in browser
      final uri = Uri.parse(checkoutUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        // Note: The actual subscription completion will be handled via webhook
        // and the user will be redirected back to the app
        emit(state.copyWith(isLoading: false));
      } else {
        throw Exception('Could not launch checkout URL');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> purchaseAddOn(String addOnType) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      // Create checkout session for add-on
      final checkoutUrl = await _repository.createAddOnCheckoutSession(addOnType);

      // Open Stripe Checkout in browser
      final uri = Uri.parse(checkoutUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        // Note: The actual payment completion will be handled via webhook
        emit(state.copyWith(isLoading: false));
      } else {
        throw Exception('Could not launch checkout URL');
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
