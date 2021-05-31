abstract class OrderStates {}

class IntialOrderState extends OrderStates {}

class LoadingOrderState extends OrderStates {}

class LoadedOrderState extends OrderStates {}

class ErrorOrderState extends OrderStates {
  final String error;

  ErrorOrderState(this.error);
}
