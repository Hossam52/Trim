import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/barber.dart';

class AllPersonsModel {
  List<Salon> allPersons = [];

  AllPersonsModel.fromJson({Map<String, dynamic> json}) {
    if (json['data'] != null) {
      (json['data'] as List).forEach((person) {
        allPersons.add(Salon.fromJson(json: person));
      });
    }
  }
}
