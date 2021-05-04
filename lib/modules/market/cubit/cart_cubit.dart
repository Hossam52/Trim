import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/cubit/cart_states.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/utils/services/rest_api_service.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  CartBloc() : super(InitialStateGetCartItems());
  Map<int, CartItem> items = {};

  @override
  Stream<CartStates> mapEventToState(CartEvents event) async* {
    if (event is CartItemsEvent) {
      yield InitialStateGetCartItems();
      await getCartItems();
      yield LoadedStateGetCartItems();
    }
    if (event is AddingItemEvent) {
      await addItem(event.cartItem);
      yield AddItem();
    } else if (event is DecreaseEvent) {
      decreaseQuantity(event.id);
      yield UpdatedItem();
    } else if (event is DeleteItemEvent) {
      removeItem(id: event.id, rowId: event.rowId);
      yield DeleteItem();
    }
  }

  List<CartItem> getCartList() {
    return items.values.toList();
  }

  double getTotalPrice() {
    double totalPrice = 0;
    items.forEach((key, value) {
      totalPrice += double.parse(value.price) * double.parse(value.quantity);
    });
    return totalPrice;
  }

  void decreaseQuantity(int index) {
    int rowId, qty;
    bool isFound = items.containsKey(index);
    if (isFound) {
      items.update(index, (value) {
        qty =
            int.parse(value.quantity) <= 1 ? 0 : int.parse(value.quantity) - 1;
        rowId = value.rowId;
        return CartItem(
          quantity: qty.toString(),
          price: value.price,
          id: value.id,
          imageName: value.imageName,
          nameAr: value.nameAr,
          rowId: value.rowId,
          nameEn: value.nameEn,
        );
      });
      print('Decrease');
      if (qty == 0) {
        items.remove(index);
        deleteItemFromCart(rowId);
      } else
        updateItemToCart(quantity: qty.toString(), rowId: rowId);
    }
  }

  void removeItem({int rowId, int id}) {
    print('Third');
    items.remove(id);
    deleteItemFromCart(rowId);
  }

  Future<void> getCartItems() async {
    try {
      final response =
          await DioHelper.getData(methodUrl: getCartItemsUrl, queries: {});
      var cartItems = response.data['data'];
      for (var cartItem in cartItems)
        items.putIfAbsent(cartItem['id'], () => CartItem.fromjson(cartItem));
      print(cartItems);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addItem(CartItem cartItem) async {
    int rowIdd;
    if (items.containsKey(cartItem.id)) {
      int qty;
      items.update(cartItem.id, (value) {
        rowIdd = value.rowId;
        qty = int.parse(value.quantity) + 1;
        print('value of row id : ${value.rowId}');
        return CartItem(
          id: value.id,
          imageName: value.imageName,
          rowId: value.rowId,
          quantity: qty.toString(),
          price: value.price,
          nameAr: value.nameAr,
          nameEn: value.nameEn,
        );
      });
      print('Row Id ${rowIdd}\n');
      updateItemToCart(quantity: qty.toString(), rowId: rowIdd);
    } else {
      int rowId = await addItemToCart(cartItem);
      items.putIfAbsent(
        cartItem.id,
        () => CartItem(
          id: cartItem.id,
          imageName: cartItem.imageName,
          nameAr: cartItem.nameAr,
          nameEn: cartItem.nameEn,
          price: cartItem.price,
          quantity: '1',
          rowId: rowId,
        ),
      );
    }
  }

  Future<int> addItemToCart(CartItem cartItem) async {
    print('First');
    print(cartItem.quantity);
    final response = await DioHelper.postData(url: addToCartUrl, body: {
      'item_id': cartItem.id,
      'quantity': cartItem.quantity == '0' ? '1' : cartItem.quantity,
      'type': 'product',
    });
    print('insideAddToCart : ${response.data['data']['row_id']}');
    return response.data['data']['row_id'];
  }

  void updateItemToCart({int rowId, String quantity}) async {
    print('Second');
    final response = await DioHelper.postData(url: updateCartItemUrl, body: {
      'row_id': rowId,
      'quantity': quantity,
    });
    print('update\n');
    print(response.data);
  }

  void deleteItemFromCart(int rowId) async {
    final response = await DioHelper.postData(url: deleteCartItemUrl, body: {
      'row_id': rowId,
    });
    print('Delete\n');
    print(response.data);
  }

  void updateItem(int id) {
    if (items.containsKey(id))
      items.update(id, (value) {
        int qty = int.parse(value.quantity) + 1;
        double price = double.parse(value.price) * qty;
        return CartItem(
          id: value.id,
          imageName: value.imageName,
          rowId: value.rowId,
          quantity: qty.toString(),
          price: price.toStringAsFixed(2),
        );
      });
  }
}
