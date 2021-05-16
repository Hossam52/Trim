import 'package:trim/modules/market/models/cartItem.dart';

abstract class ProductsOrderEvents {
  final List<CartItem> productsOrder;
  final String coupon;
  final String address;
  final String phone;

  ProductsOrderEvents(this.productsOrder, this.coupon,this.address,this.phone);
}

class PostDataOrderProducts extends ProductsOrderEvents {
  PostDataOrderProducts({List<CartItem> productsOrder, String coupon,String address,String phone})
      : super(productsOrder, coupon,address,phone);
}
