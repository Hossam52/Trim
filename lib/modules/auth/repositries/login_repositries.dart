import 'package:trim/api_reponse.dart';
import 'package:trim/utils/services/call_api.dart';

import '../models/login_model.dart';
import 'package:trim/constants/api_path.dart';

Future<APIResponse<LoginModel>> loginUser(
    String userName, String password) async {
  final response = await callAPI(loginUrl,
      body: {'text': userName, 'password': password}, callType: CallType.Post);
  if (response.error) {
    print(response.data);
    return APIResponse<LoginModel>(
        error: true, errorMessage: response.data['message']);
  } else {
    return APIResponse<LoginModel>(
        data: LoginModel.fromJson(json: response.data['data']));
  }
}
