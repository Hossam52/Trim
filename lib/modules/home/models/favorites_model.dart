import 'package:flutter/foundation.dart';
import 'package:trim/modules/home/models/Salon.dart';

class FavoritesModel {
  List<Salon> favoriteList = [];

  FavoritesModel.fromJson({@required Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((favorite) {
        favoriteList.add(Salon.fromJson(json: favorite));
      });
    }
  }
}
