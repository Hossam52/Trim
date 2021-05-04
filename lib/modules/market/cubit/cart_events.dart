import 'package:trim/modules/market/models/cartItem.dart';

abstract class CartEvents {}

class CartItemsEvent extends CartEvents{}
class AddingItemEvent extends CartEvents {
  final CartItem cartItem;
  AddingItemEvent({this.cartItem});
}

class DecreaseEvent extends CartEvents {
  final int id;
  DecreaseEvent({this.id});
}

class DeleteItemEvent extends CartEvents {
    final int id;
      final int rowId;
  DeleteItemEvent({this.id,this.rowId});
}
