import 'package:flutter/foundation.dart';

class ContactEmailModel {
  int id;
  String email;

  ContactEmailModel.fromJson({@required Map<String, dynamic> json}) {
    id = json['id'] ?? 0;
    email = json['email'] ?? 'Unknown email';
  }
}
