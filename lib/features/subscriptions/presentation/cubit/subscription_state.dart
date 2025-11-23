import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    @Default(false) bool isLoading,
    @Default(false) bool isMonthlyBilling,
    String? errorMessage,
  }) = _SubscriptionState;
}
