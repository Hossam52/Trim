import 'package:flutter/foundation.dart';
import 'package:trim/modules/settings/models/contact_email_model.dart';
import 'package:trim/modules/settings/models/contact_phone_model.dart';

class ContactsModel {
  List<ContactEmailModel> contactEmails = [];
  List<ContactPhoneModel> contactPhones = [];

  ContactsModel.fromJson({@required Map<String, dynamic> json}) {
    if (json['emails'] != null) {
      (json['emails'] as List).forEach((email) {
        contactEmails.add(ContactEmailModel.fromJson(json: email));
      });
    }
    if (json['phones'] != null) {
      (json['phones'] as List).forEach((phone) {
        contactPhones.add(ContactPhoneModel.fromJson(json: phone));
      });
    }
  }
}
