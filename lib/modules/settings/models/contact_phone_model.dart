import 'package:flutter/foundation.dart';

class ContactPhoneModel {
  int id;
  String phone;

  ContactPhoneModel.fromJson({@required Map<String, dynamic> json}) {
    id = json['id'] ?? 0;
    phone = json['phone'] ?? 'Unknown Phone';
  }
}
