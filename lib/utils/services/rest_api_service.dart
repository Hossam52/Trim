//call the rest api to store data on remote data base and return data in case of succeded or error on failed in format 4xx or 5xx status code

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trim/constants/api_path.dart';

class DioHelper {
  static Dio dio;
  static String token = '';
  static void init({@required String accessToken}) {
    token = accessToken;
    dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          HttpHeaders.authorizationHeader: accessToken,
        }));
  }

  static Future<Response> getData(
      {@required String methodUrl,
      @required Map<String, dynamic> queries}) async {
    return await dio.get(methodUrl, queryParameters: queries);
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> queries = const {},
  }) async {
    return await dio.post(
      url,
      queryParameters: queries,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
  }
}
