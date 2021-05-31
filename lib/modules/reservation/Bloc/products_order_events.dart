import 'package:flutter/foundation.dart';
import 'package:trim/modules/market/models/cartItem.dart';

abstract class ProductsOrderEvents {
  final List<CartItem> productsOrder;
  final String coupon;
  final String address;
  final String phone;
  final String paymentMethod;
  ProductsOrderEvents(this.productsOrder, this.coupon, this.address, this.phone,
      this.paymentMethod);
}

class PostDataOrderProducts extends ProductsOrderEvents {
  PostDataOrderProducts(
      {@required List<CartItem> productsOrder,
      @required String coupon,
      @required String address,
      @required String phone,
      @required String paymentMethod})
      : super(productsOrder, coupon, address, phone, paymentMethod);
}
