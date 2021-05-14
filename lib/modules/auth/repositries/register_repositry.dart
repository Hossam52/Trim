import 'package:flutter/foundation.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/auth/models/register_model.dart';
import 'package:trim/modules/auth/models/token_model.dart';
import 'package:trim/utils/services/call_api.dart';

Future<APIResponse<RegisterModel>> registerUser(
    {@required Map<String, dynamic> body}) async {
  try {
    final response =
        await callAPI(registerUrl, body: body, callType: CallType.Post);
    if (response.error) {
      return APIResponse<RegisterModel>(
          error: true, errorMessage: _getErrorMessage(response.data['errors']));
    } else {
      return APIResponse<RegisterModel>(
          data: RegisterModel.fromJson(json: response.data['data']));
    }
  } catch (e) {
    return APIResponse(error: true, errorMessage: 'Unknown error happens');
  }
}

Future<APIResponse<TokenModel>> activateAccount(String accessToken) async {
  final response = await callAPI(activateAccountUrl,
      accessToken: accessToken, callType: CallType.Post);
  try {
    if (response.error) {
      if (response.data['message'] != null)
        return APIResponse(
            error: true, errorMessage: (response.data['message']));
      return APIResponse(
          error: true, errorMessage: response.data['errors']['sms_token'][0]);
    } else {
      return APIResponse(data: response.data['data']);
    }
  } catch (e) {
    return APIResponse(error: true, errorMessage: 'Unknown error happened.');
  }
}

String _getErrorMessage(Map<String, dynamic> jsonErrors) {
  if (jsonErrors['email'] != null) return jsonErrors['email'][0];
  if (jsonErrors['phone'] != null) return jsonErrors['phone'][0];
  if (jsonErrors['password'] != null) return jsonErrors['password'][0];
  if (jsonErrors['gender'] != null) return jsonErrors['gender'][0];
  if (jsonErrors['name'] != null) return jsonErrors['name'][0];
  return 'Unknown error Happens';
}
