import 'dart:convert';

import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/auth/repositries/api_reponse.dart';
import 'package:http/http.dart' as http;
import 'package:trim/modules/auth/repositries/login_repositries.dart';

class LoginService {
  static const headers = {
    "api_key": "78407750-de0b-440b-9e38-ce04c887a031",
  };
  Future<APIResponse<LoginRepositry>> makeLogin(
      String user, String password) async {
    String errorMessage = 'Email or password is incorrect.';

    try {
      return http.post(Uri.parse(loginApi),
          headers: headers,
          body: {"text": user, "password": password}).then((data) {
        final Map<String, dynamic> jsonData = json.decode(data.body);
        if (jsonData['success'] as bool) {
          print(jsonData['data']);
          return APIResponse<LoginRepositry>(
            data: LoginRepositry.fromJson(jsonData['data']),
          );
        }
        errorMessage = jsonData['message'];
        return APIResponse<LoginRepositry>(
            error: true, errorMessage: errorMessage);
      }).catchError((_) =>
          APIResponse<LoginRepositry>(error: true, errorMessage: errorMessage));
    } catch (e) {
      return Future.value(
          APIResponse<LoginRepositry>(error: true, errorMessage: errorMessage));
    }
  }
}
