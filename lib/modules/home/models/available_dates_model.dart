import 'package:flutter/foundation.dart';

class AvilableDatesModel {
  List<String> avilableDates = [];
  AvilableDatesModel.fromJson({@required Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((date) {
        avilableDates.add(date);
      });
    }
  }
}
