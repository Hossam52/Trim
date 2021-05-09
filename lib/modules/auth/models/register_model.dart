import 'package:flutter/foundation.dart';
import 'package:trim/modules/auth/models/login_model.dart';

class RegisterModel {
  String accessToken;
  LoginModel user;

  RegisterModel.fromJson({@required json}) {
    accessToken = json['token']['accessToken'];
    user = LoginModel.fromJson(json: json['user']);
  }
}
