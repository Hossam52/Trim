import 'package:dio/dio.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/modules/auth/models/token_model.dart';
import 'package:trim/utils/services/call_api.dart';

import '../models/login_model.dart';
import 'package:trim/constants/api_path.dart';

Future<APIResponse<TokenModel>> loginUser(
    String userName, String password) async {
  final response = await callAPI(loginUrl,
      body: {'text': userName, 'password': password}, callType: CallType.Post);
  if (response.error) {
    print(response.data);
    return APIResponse<TokenModel>(
        error: true, errorMessage: response.errorMessage);
  } else {
    return APIResponse<TokenModel>(
        data: TokenModel.fromJson(json: response.data['data']));
  }
}

Future<APIResponse<LoginModel>> getUserProfileData() async {
  final response = await callAPI(personalProfileUrl, callType: CallType.Get);
  if (response.error)
    return APIResponse(error: true, errorMessage: response.errorMessage);
  // else return APIResponse<LoginModel
}

Future<APIResponse<Map<String, dynamic>>> updateUserInformationFromServer(
    FormData body) async {
  final response =
      await callAPI(updateUserInfoUrl, formData: body, callType: CallType.Post);
  if (response.error)
    return APIResponse(error: true, errorMessage: response.errorMessage);
  else
    return APIResponse<Map<String, dynamic>>(data: response.data);
}
