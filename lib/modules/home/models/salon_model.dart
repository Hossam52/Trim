import 'package:trim/modules/home/models/Salon.dart';

class SalonModel {
  Salon salon;
  SalonModel.fromJson({Map<String, dynamic> json}) {
    salon = Salon.fromJson(json: json['data']);
  }
}
