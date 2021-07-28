import 'package:flutter/foundation.dart';

import 'package:trim/modules/home/models/Salon.dart';

class _AllData {
  List<Salon> allData = [];
  _AllData.fromJson({@required Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((salon) {
        allData.add(Salon.fromJson(json: salon));
      });
    }
  }
}

class FavoritesModel extends _AllData {
  FavoritesModel.fromJson({@required Map<String, dynamic> json})
      : super.fromJson(json: json);
}

class AllPersonsModel extends _AllData {
  AllPersonsModel.fromJson({@required Map<String, dynamic> json})
      : super.fromJson(json: json);
}

class AllSalonsModel extends _AllData {
  AllSalonsModel.fromJson({@required Map<String, dynamic> json})
      : super.fromJson(json: json);
}
