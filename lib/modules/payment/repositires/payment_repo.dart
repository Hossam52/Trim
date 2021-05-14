import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/payment/models/payment_model.dart';
import 'package:trim/modules/payment/models/refund_model.dart';

Dio _dio;
void initPayment() {
  _dio = Dio(BaseOptions(
    baseUrl: paymentUrl,
    headers: {
      HttpHeaders.authorizationHeader: secretPaymentKey,
    },
    validateStatus: (_) => true,
  ));
}

Future<APIResponse<String>> getTokenFromServer({
  @required String cardNumber,
  @required String expiryMonth,
  @required String expiryYear,
  @required String name,
  @required String cvv,
}) async {
  final response = await _dio.post('tokens',
      data: {
        'type': 'card',
        'number': cardNumber,
        'expiry_month': expiryMonth,
        'expiry_year': expiryYear,
        'name': name,
        'cvv': cvv
      },
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: publicPaymentKey,
        },
      ));
  switch (response.statusCode) {
    case 201:
      return APIResponse(data: response.data['token']);
      break;
    case 422:
      return APIResponse(
          error: true, errorMessage: response.data['error_codes'][0]);
      break;
    case 401:
      return APIResponse(error: true, errorMessage: 'Not Not Authorized');
      break;
    default:
  }
}

Future<APIResponse<PaymentModel>> makePaymentFromServer(
    {@required int amount, @required String token, String reference}) async {
  final response = await _dio.post(
    'payments',
    data: {
      'source': {
        'type': 'token',
        'token': token,
      },
      'currency': 'EGP',
      'amount': amount,
      'customer': {'email': 'abc@gmail.com', 'name': 'Ahmed Hassan'},
      'reference': reference
    },
  );
  switch (response.statusCode) {
    case 201:
    case 202:
      if (response.data['approved'])
        return APIResponse<PaymentModel>(
            data: PaymentModel.fromJson(response.data));
      return APIResponse<PaymentModel>(
          error: true, errorMessage: response.data['response_summary']);

      break;
    case 401:
      print('Un authroized');
      return APIResponse<PaymentModel>(
          error: true, errorMessage: 'Un authroized');
      break;
    case 422:
    case 429:
      return APIResponse<PaymentModel>(
          error: true, errorMessage: response.data['error_codes'][0]);
      break;
    case 502:
      print('Bad Gateway');
      return APIResponse<PaymentModel>(
          error: true, errorMessage: 'Un authroized');
      break;
    default:
  }
}

Future<APIResponse<RefundModel>> makeRefund(
    {@required String id, int amount = 0}) async {
  final response = await _dio.post(
    'payments/$id/refunds',
    data: {'amount': amount},
  );
  switch (response.statusCode) {
    case 202:
      print('refund accepted');
      return APIResponse<RefundModel>(
          data: RefundModel.fromJson(response.data));
      break;
    case 401:
      print('Un authrized');
      return APIResponse(error: true, errorMessage: 'Un Authrorized');
      break;
    case 403:
      print('Refund Not Allowed');
      return APIResponse(error: true, errorMessage: 'Refund Not Allowed');
      break;
    case 404:
      print('Payment not found');
      return APIResponse(error: true, errorMessage: 'Payment not found');
      break;
    case 422:
      print('Invalid Data was Sent');
      return APIResponse(error: true, errorMessage: 'Invalid Data was Sent');
      break;
    case 502:
      print('Bad Gateway');
      return APIResponse(error: true, errorMessage: 'Bad Gateway');
      break;
    default:
  }
}

Future<bool> isValid({
  @required String cardNumber,
  @required String expiryMonth,
  @required String expiryYear,
  @required String name,
  @required String cvv,
}) async {}
