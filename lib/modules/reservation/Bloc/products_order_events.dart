import 'package:trim/modules/market/models/cartItem.dart';

abstract class ProductsOrderEvents {
  final List<CartItem> productsOrder;
  final String coupon;

  ProductsOrderEvents(this.productsOrder,this.coupon);
}

class PostDataOrderProducts extends ProductsOrderEvents {
  PostDataOrderProducts({List<CartItem> productsOrder,String coupon}) : super(productsOrder,coupon);
}
