import 'package:flutter/material.dart';
import 'package:trim/modules/auth/models/login_model.dart';

class TokenModel {
  String token;
  LoginModel loginModel;

  TokenModel.fromJson({@required Map<String, dynamic> json}) {
    token = json['token'];
    loginModel = LoginModel.fromJson(json: json);
  }
}
