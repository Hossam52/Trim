abstract class ProductOrderStates {}

class InitialStateProductsOrder extends ProductOrderStates {}

class LoadingStateProductsOrder extends ProductOrderStates {}

class LoadedStateProductsOrder extends ProductOrderStates {
  final List<Map<String, dynamic>> productsOrder;
  LoadedStateProductsOrder(this.productsOrder);
}

class ErrorStateProductsOrder extends ProductOrderStates {}
