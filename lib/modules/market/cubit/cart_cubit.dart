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
    try {
      if (event is CartItemsEvent) {
        yield InitialStateGetCartItems();
        await getCartItems();
        yield LoadedStateGetCartItems();
      } else if (event is DeleteAllItemsInCart) {
        await deleteAllitemsFromCart(); //added
        yield DeleteAllItems();
      } else if (event is AddingItemEvent) {
        await addItem(event.cartItem);
        yield AddItem();
      } else if (event is DecreaseEvent) {
        await decreaseQuantity(event.id);
        yield UpdatedItem();
      } else if (event is DeleteItemEvent) {
        await removeItem(id: event.id, rowId: event.rowId);
        yield DeleteItem();
      }
    } catch (e) {
      if (event.screenId == '1') {
        yield ErrorStateCart();
      } else if (event.screenId == '2')
        yield ErrorStateCartInBadge();
      else
        yield ErrorStateCart();
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

  Future<void> decreaseQuantity(int index) async {
    try {
      int rowId, qty;
      bool isFound = items.containsKey(index);
      if (isFound) {
        rowId = items[index].rowId;
        qty = int.parse((items[index].quantity)) <= 1
            ? 0
            : int.parse(items[index].quantity) - 1;
        if (qty == 0) {
          items.remove(index);
          deleteItemFromCart(rowId);
        } else {
          updateItemToCart(quantity: qty.toString(), rowId: rowId);
          items.update(index, (value) {
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
        }
      }
    } catch (e) {
      throw Exception;
    }
  }

  Future<void> removeItem({int rowId, int id}) async {
    try {
      await deleteItemFromCart(rowId);
      items.remove(id);
    } catch (e) {
      throw e;
    }
  }

  Future<void> getCartItems() async {
    try 
    {
      final response =
          await DioHelper.getData(methodUrl: getCartItemsUrl, queries: {});
      var cartItems = response.data['data'];
      for (var cartItem in cartItems)
        items.putIfAbsent(cartItem['id'], () => CartItem.fromjson(cartItem));
    } catch (e) {}
  }

  Future<void> addItem(CartItem cartItem) async {
    try {
      if (items.containsKey(cartItem.id)) {
        int rowIdd = items[cartItem.id].rowId;
        int qty = int.parse((items[cartItem.id].quantity)) + 1;
        updateItemToCart(quantity: qty.toString(), rowId: rowIdd);
        items.update(cartItem.id, (value) {
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
        //Error Here
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
    } catch (e) {
      throw Exception;
    }
  }

  Future<int> addItemToCart(CartItem cartItem) async {
    try {
      final response = await DioHelper.postData(url: addToCartUrl, body: {
        'item_id': cartItem.id,
        'quantity': cartItem.quantity == '0' ? '1' : cartItem.quantity,
        'type': 'product',
      });
      return response.data['data']['row_id'];
    } catch (e) {
      throw Exception;
    }
  }

  Future<void> updateItemToCart({int rowId, String quantity}) async {
    try {} catch (e) {
      throw Exception;
    }
  }

  Future<void> deleteItemFromCart(int rowId) async {
    try {
      await DioHelper.postData(url: deleteCartItemUrl, body: {
        'row_id': rowId,
      });
    } catch (e) {
      throw Exception;
    }
  }

  Future<void> deleteAllitemsFromCart() async {
    try {
      await DioHelper.postData(url: deleteAllCartItemsUrl, body: {});
      items.clear();
    } catch (e) {
      throw Exception;
    }
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

  void resetData() {
    items.clear();
  }
}
