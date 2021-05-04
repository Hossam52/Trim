import 'package:flutter/foundation.dart';
import 'package:trim/utils/services/rest_api_service.dart';

class RecievedData {
  Map<String, dynamic> data;
  bool error;
  String errorMessage;
  RecievedData(
      {@required this.data, @required this.error, @required this.errorMessage});
}

enum CallType {
  Get,
  Post,
}
Future<RecievedData> callAPI(String url,
    {Map<String, dynamic> body = const {},
    Map<String, dynamic> quiries = const {},
    @required CallType callType}) async {
  String error = "Un expected error happened";
  Map<String, dynamic> data;
  try {
    final response = callType == CallType.Post
        ? await DioHelper.postData(url: url, body: body, queries: quiries)
        : await DioHelper.getData(methodUrl: url, queries: quiries);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.data['success'] != true)
        error = response.data['message'];
      else
        try {
          return RecievedData(
              data: response.data, error: false, errorMessage: "");
        } catch (e) {
          error = 'Error:${e.toString()} occured.';
        }
    } else if (response.statusCode == 404)
      error = 'The requested page is not found try again!';
    else if (response.statusCode >= 400 && response.statusCode < 500)
      error = 'Client side error please modify it then retry.';
  } on Exception catch (e) {
    error = 'Un expected error happened';
  }
  return RecievedData(data: data, error: true, errorMessage: error);
}
