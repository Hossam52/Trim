import 'package:flutter/foundation.dart';
import 'package:trim/basic_data_model.dart';

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

class CityModel extends BasicData {
  int id;
  CityModel({this.id, String nameArabic, String nameEnglish}) {
    nameAr = nameArabic;
    nameEn = nameEnglish;
  }
  CityModel.fromJson({@required Map<String, dynamic> json}) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }
}
