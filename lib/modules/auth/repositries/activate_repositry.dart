import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/auth/models/token_model.dart';
import 'package:trim/utils/services/call_api.dart';

Future<APIResponse<TokenModel>> activateAccount(
    String token, String code) async {
  final response = await callAPI(activateAccountUrl,
      body: {'sms_token': code}, accessToken: token, callType: CallType.Post);

  if (response.error)
    return APIResponse(error: true, errorMessage: response.errorMessage);
  else
    return APIResponse<TokenModel>(
        data: TokenModel.fromJson(json: response.data['data']));
}

Future<APIResponse<TokenModel>> requestNewCode(String phone) async {
  final response = await callAPI(resetPasswordUrl,
      body: {'text': phone}, callType: CallType.Post);
  if (response.error) {
    return APIResponse(error: true, errorMessage: response.errorMessage);
  } else {
    return APIResponse<TokenModel>(
        data: TokenModel.fromJson(json: response.data['data']));
  }
}
