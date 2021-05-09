import 'package:dio/dio.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/utils/services/call_api.dart';
import '../models/contacts_model.dart';
import '../../../constants/api_path.dart';

Future<APIResponse<ContactsModel>> getCtonatctsFromServer() async {
  final response = await Dio().get('https://trim.style/public/api/contacts');
  try {
    if (response.statusCode != 200)
      return APIResponse<ContactsModel>(
          error: true, errorMessage: "Error has happened");
    else
      return APIResponse<ContactsModel>(
          data: ContactsModel.fromJson(json: response.data['data']));
  } catch (e) {
    return APIResponse<ContactsModel>(
        error: true, errorMessage: "Error has happened");
  }
}
