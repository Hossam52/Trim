import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/reservation/Bloc/products_order_events.dart';
import 'package:trim/modules/reservation/Bloc/products_order_states.dart';
import 'package:trim/utils/services/rest_api_service.dart';

class ProductsOrderBloc extends Bloc<ProductsOrderEvents, ProductOrderStates> {
  ProductsOrderBloc() : super(InitialStateProductsOrder());
  List<Map<String, dynamic>> productsOrder;

  @override
  Stream<ProductOrderStates> mapEventToState(ProductsOrderEvents event) async* {
    try {
      yield LoadingStateProductsOrder();
      productsOrder = [];
      for (CartItem item in event.productsOrder)
        productsOrder.add({
          'product_id': item.id,
          'quantity': item.quantity,
        });
      final response =
          await DioHelper.postData(url: newOrderWithProductUrl, body: {
        'products': productsOrder,
        'payment_coupon':event.coupon,
      });
      print(response.data);
      yield LoadedStateProductsOrder(productsOrder);
    } catch (e) {
      
      yield ErrorStateProductsOrder();
    }
  }
}
