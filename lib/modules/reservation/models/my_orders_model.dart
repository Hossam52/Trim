import 'package:flutter/foundation.dart';
import 'package:trim/modules/reservation/models/order_model.dart';

class MyOrdersModel {
  List<OrderModel> myReservations = [];

  MyOrdersModel.fromJson({@required Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((reservation) {
        myReservations.add(OrderModel.fromJson(reservation));
      });
    }
  }
}
