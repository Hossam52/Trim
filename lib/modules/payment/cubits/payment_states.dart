abstract class PaymentStates {}

class IntialPaymentState extends PaymentStates {}

class ChangePaymentMethodState extends PaymentStates {}

class LoadingTokenState extends PaymentStates {}

class LoadedTokenState extends PaymentStates {}

class ErrorPaymentState extends PaymentStates {
  final String errorMessage;
  ErrorPaymentState(this.errorMessage);
}

class LoadingPaymentState extends PaymentStates {}

class LoadedPaymentState extends PaymentStates {}

class ChangeCardDataState extends PaymentStates {}
