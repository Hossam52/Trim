import 'package:flutter/foundation.dart';

class Cities {
  List<CityModel> cities = [];
  Cities.fromJson({@required Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((city) {
        cities.add(CityModel.fromJson(json: city));
      });
    }
  }
}

class CityModel {
  int id;
  String nameEn;
  String nameAr;
  CityModel({this.id, this.nameAr, this.nameEn});
  CityModel.fromJson({@required Map<String, dynamic> json}) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }
}
