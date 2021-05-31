import 'package:dio/dio.dart';
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
    FormData formData,
    Map<String, dynamic> quiries = const {},
    String accessToken,
    @required CallType callType}) async {
  String error = "Un expected error happened";
  Map<String, dynamic> data;
  try {
    Response response;
    if (callType == CallType.Post) {
      if (formData != null) {
        response = await DioHelper.postDataToImages(
            url: url,
            accessToken: accessToken,
            formData: formData,
            queries: quiries);
      } else {
        response = await DioHelper.postData(
            url: url, accessToken: accessToken, body: body, queries: quiries);
      }
    } else {
      response = await DioHelper.getData(
          methodUrl: url, accessToken: accessToken, queries: quiries);
    }
    data = response.data;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if ((response.data['success'] != null &&
              response.data['success'] != true) ||
          (response.data['status'] != null &&
              response.data['status'] != 'success'))
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
    else if (response.statusCode >= 400 && response.statusCode < 500) {
      if (response.data['message'] != null)
        error = response.data['message'];
      else if (response.data['errors'] != null) {
        error = (response.data['errors'] as Map<String, dynamic>)
            .entries
            .toList()[0]
            .value[0];
      } else
        error = 'Client side error please modify it then retry.';
    }
  } catch (e) {
    error = 'Un expected error happened';
  }
  return RecievedData(data: data, error: true, errorMessage: error);
}
