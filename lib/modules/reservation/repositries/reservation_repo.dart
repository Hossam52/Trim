import 'package:flutter/foundation.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/reservation/models/my_orders_model.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/utils/services/call_api.dart';

Future<APIResponse<MyOrdersModel>> loadMyOrdersFromServer() async {
  final response = await callAPI(myOrdersUrl, callType: CallType.Get);
  if (response.error) {
    return APIResponse<MyOrdersModel>(
        error: true, errorMessage: response.errorMessage);
  } else {
    return APIResponse<MyOrdersModel>(
        data: MyOrdersModel.fromJson(json: response.data));
  }
}

Future<APIResponse<bool>> cancelOrderFromServer(
    {@required int orderId, @required String cancelReason}) async {
  final response = await callAPI(cancelOrderUrl,
      body: {'order_id': orderId, 'reason': cancelReason},
      callType: CallType.Post);
  if (response.error)
    return APIResponse(error: true);
  else
    return APIResponse(data: true);
}

Future<APIResponse<OrderModel>> orderProductsFromServer(
    Map<String, dynamic> body) async {
  final response = await callAPI(newOrderWithProductUrl,
      body: body, callType: CallType.Post);
  if (response.error)
    return APIResponse(error: true, errorMessage: response.errorMessage);
  return APIResponse<OrderModel>(data: OrderModel.fromJson(response.data));
}
