import 'package:trim/modules/market/models/cartItem.dart';

abstract class ProductsOrderEvents {
  final List<CartItem> productsOrder;

  ProductsOrderEvents(this.productsOrder);
}

class PostDataOrderProducts extends ProductsOrderEvents {
  PostDataOrderProducts({List<CartItem> productsOrder})
      : super(productsOrder);
}
