import 'package:trim/modules/market/models/cartItem.dart';

abstract class CartEvents {
  final String screenId;
  CartEvents(this.screenId);
}

class CartItemsEvent extends CartEvents {
  CartItemsEvent({String screenId}) : super(screenId);
}

class AddingItemEvent extends CartEvents {
  final CartItem cartItem;
  AddingItemEvent({this.cartItem, String screenId}) : super(screenId);
}

class DecreaseEvent extends CartEvents {
  final int id;
  DecreaseEvent({this.id, String screenId}) : super(screenId);
}

class DeleteItemEvent extends CartEvents {
  final int id;
  final int rowId;
  DeleteItemEvent({this.id, this.rowId,String screenId }) : super(screenId);
}
