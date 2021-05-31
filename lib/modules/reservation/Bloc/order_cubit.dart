import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/reservation/Bloc/order_states.dart';
import 'package:trim/modules/reservation/repositries/reservation_repo.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(IntialOrderState());

  static OrderCubit getInstance(context) =>
      BlocProvider.of<OrderCubit>(context);

  Future<void> makeOrderProducts({
    @required List<CartItem> cartItems,
    @required String coupon,
    @required String phone,
    @required String address,
    @required String paymentMethod,
  }) async {
    final List<Map<String, dynamic>> productsOrder = [];
    for (CartItem item in cartItems)
      productsOrder.add({
        'product_id': item.id,
        'quantity': item.quantity,
      });
    Map<String, dynamic> body = {};
    body['products'] = productsOrder;
    body['address'] = address;
    body['phone'] = phone;
    body['payment_method'] = paymentMethod;
    if (coupon != null && coupon.isNotEmpty) body['payment_coupon'] = coupon;
    emit(LoadingOrderState());
    final response = await orderProductsFromServer(body);
    if (response.error) {
      emit(ErrorOrderState(response.errorMessage));
    } else {
      emit(LoadedOrderState());
    }
  }
}
