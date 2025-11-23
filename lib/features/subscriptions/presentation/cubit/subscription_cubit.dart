import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team2/features/subscriptions/data/repositories/subscription_repository_impl.dart';
import 'package:team2/features/subscriptions/presentation/cubit/subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SubscriptionRepository _repository = SubscriptionRepository();

  SubscriptionCubit() : super(const SubscriptionState());

  // Flag to track if purchase was successful (for navigation)
  bool _purchaseSuccessful = false;
  bool get purchaseSuccessful => _purchaseSuccessful;
  
  void resetPurchaseFlag() {
    _purchaseSuccessful = false;
  }

  void toggleBillingType() {
    emit(state.copyWith(isMonthlyBilling: !state.isMonthlyBilling));
  }

  void setMonthlyBilling(bool isMonthly) {
    emit(state.copyWith(isMonthlyBilling: isMonthly));
  }

  Future<void> purchasePlan(String planType) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    _purchaseSuccessful = false;
    
    try {
      // Simulate processing delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock purchase - update Firestore directly (for testing without Stripe)
      await _repository.mockPurchasePlan(planType);
      
      _purchaseSuccessful = true;
      emit(state.copyWith(isLoading: false));
      
      // Note: In production, this would call Stripe checkout:
      // final checkoutUrl = await _repository.createPlanCheckoutSession(planType);
      // final uri = Uri.parse(checkoutUrl);
      // await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      String errorMessage = 'Failed to process subscription';
      if (e.toString().contains('authenticated')) {
        errorMessage = 'Please sign in to continue';
      } else if (e.toString().contains('not found')) {
        errorMessage = 'Employer profile not found. Please complete your profile first.';
      } else {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      
      _purchaseSuccessful = false;
      emit(state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> purchaseAddOn(String addOnType) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    _purchaseSuccessful = false;
    
    try {
      // Simulate processing delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock purchase - update Firestore directly (for testing without Stripe)
      await _repository.mockPurchaseAddOn(addOnType);
      
      _purchaseSuccessful = true;
      emit(state.copyWith(isLoading: false));
      
      // Note: In production, this would call Stripe checkout:
      // final checkoutUrl = await _repository.createAddOnCheckoutSession(addOnType);
      // final uri = Uri.parse(checkoutUrl);
      // await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      String errorMessage = 'Failed to process add-on';
      if (e.toString().contains('authenticated')) {
        errorMessage = 'Please sign in to continue';
      } else if (e.toString().contains('not found')) {
        errorMessage = 'Employer profile not found. Please complete your profile first.';
      } else if (e.toString().contains('Invalid add-on type')) {
        errorMessage = 'Invalid add-on selected. Please try again.';
      } else {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      
      _purchaseSuccessful = false;
      emit(state.copyWith(
        isLoading: false,
        errorMessage: errorMessage,
      ));
    }
  }
}
