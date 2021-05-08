import 'package:trim/modules/home/models/Salon.dart';

class AllSalonsModel {
  List<Salon> allSalons = [];

  AllSalonsModel.fromJson({Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((salon) {
        allSalons.add(Salon.fromJson(json: salon));
      });
    }
  }
}
