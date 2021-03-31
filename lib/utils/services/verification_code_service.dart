import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trim/constants/api_path.dart';

import 'package:trim/modules/auth/repositries/api_reponse.dart';

class ActivationProcessServices {
  //return token of the current user
  Future<APIResponse<String>> activateAccount(
      String userName, String password, String verificationCode) {
    return getVerificationCode(userName, password).then((value) {
      if (!value.error) {
        return activate(value.data).then((response) {
          return response;
        });
      } else
        return value;
    });
  }

  Future<APIResponse<String>> activate(String verificationCode) {
    const headers = {'api_key': 'd3fa02e7-e373-4ebf-ba0d-0496149d34c4'};
    Map<String, dynamic> body = {"sms_token": verificationCode};
    Uri url = Uri.parse(activateApi);
    return http.post(url, headers: headers, body: body).then((response) {
      Map<String, dynamic> josnData = json.decode(response.body);
      if (response.statusCode == 200) {
        return APIResponse<String>(data: josnData['data']['token'] as String);
      }
      return APIResponse<String>(
          error: true,
          errorMessage: 'You are not autorize to make this porcess');
    }).catchError((value) => APIResponse<String>(
        error: true, errorMessage: 'An error has been occured'));
  }

  Future<APIResponse<String>> getVerificationCode(
      String userName, String password) {
    const headers = {
      'api_key': 'c63fd642-b0a5-41a2-8a29-f229657f46fa',
    };
    Map<String, dynamic> body = {'text': userName, 'password': password};
    try {
      Uri url = Uri.parse(getVerificationCodeApi);
      return http.post(url, headers: headers, body: body).then((response) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        if (response.statusCode == 200) {
          String code = jsonData['data']['code'];

          return APIResponse<String>(data: code);
        }
        return APIResponse<String>(
            error: true, errorMessage: 'An Error has been occured');
      }).catchError((value) => APIResponse<String>(
          error: true, errorMessage: 'An Error has been occured'));
    } catch (e) {
      throw e.toString();
    }
  }
}
