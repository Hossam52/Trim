import 'package:flutter/foundation.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/reservation/models/my_orders_model.dart';
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

Future<APIResponse<int>> cancelOrderFromServer(
    {@required int orderId, @required String cancelReason}) async {
  final response = await callAPI(cancelOrderUrl,
      body: {'order_id': orderId, 'reason': cancelReason},
      callType: CallType.Post);
  print(response.data);
}
