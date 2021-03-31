import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/auth/repositries/api_reponse.dart';
import 'package:trim/modules/auth/repositries/register_repositry.dart';

class RegisterService {
  Map<String, String> headers = {
    "api_key": "982fc481-9ad9-4dec-a62c-5bd054c3dbc9"
  };
  Future<APIResponse<String>> signUp(RegisterReposistry data) {
    String errorMessage = 'Unknown error has occured';
    try {
      return http
          .post(Uri.parse(registerApi), headers: headers, body: (data.toJson()))
          .then((response) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        if (response.statusCode == 200) {
          return APIResponse<String>(
              data: jsonData['data']['token']['accessToken']);
        }
        //print(jsonData['errors']);
        Map<String, dynamic> errors = jsonData['errors'];
        if (errors['email'] != null)
          errorMessage = errors['email'][0];
        else if (errors['phone'] != null) errorMessage = errors['phone'][0];
        return APIResponse<String>(error: true, errorMessage: errorMessage);
      }).catchError(
        (_) => APIResponse<String>(error: true, errorMessage: errorMessage),
      );
    } catch (e) {
      return Future.value(
          APIResponse<String>(error: true, errorMessage: errorMessage));
    }
  }
}
