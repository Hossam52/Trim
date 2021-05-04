import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/home_model.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/modules/home/models/all_salons_model.dart';
import 'package:trim/api_reponse.dart';
import '../models/all_persons_model.dart';
import '../models/salon_model.dart';
import 'package:trim/utils/services/call_api.dart';
import '../models/available_dates_model.dart';

Future<APIResponse<AllSalonsModel>> loadAllSalonsFromServer(int pageCount,
    {Map<String, dynamic> body = const {}}) async {
  final recievedData = await callAPI(allSalonsUrl,
      body: body, quiries: {'page': pageCount}, callType: CallType.Post);
  if (recievedData.error)
    return APIResponse<AllSalonsModel>(
        error: true, errorMessage: recievedData.errorMessage);
  else
    return APIResponse<AllSalonsModel>(
        data: AllSalonsModel.fromJson(json: recievedData.data));
}

Future<APIResponse<AllPersonsModel>> loadAllPersonsFromServer(
    int pageCount) async {
  final recievedData = await callAPI(allPersonsUrl,
      quiries: {'page': pageCount}, callType: CallType.Post);
  if (recievedData.error)
    return APIResponse<AllPersonsModel>(
        error: true, errorMessage: recievedData.errorMessage);
  else
    return APIResponse<AllPersonsModel>(
        data: AllPersonsModel.fromJson(json: recievedData.data));
}

Future<APIResponse<SalonModel>> getSalonDetailFromServer(
    {@required int salonId}) async {
  final recievedData = await callAPI(salonDetailUrl,
      body: {'salon_id': salonId}, callType: CallType.Post);
  if (recievedData.error)
    return APIResponse<SalonModel>(
        error: true, errorMessage: recievedData.errorMessage);
  else
    return APIResponse<SalonModel>(
        data: SalonModel.fromJson(json: recievedData.data));
}

Future<APIResponse<AvilableDatesModel>> getAvailableDatesFromServer(
    {@required int id, @required DateTime date}) async {
  String formattedDated = DateFormat.yMd().format(date);
  final response = await callAPI(avaliableDatesUrl,
      body: {'id': id, 'date': formattedDated}, callType: CallType.Post);
  if (response.error)
    return APIResponse<AvilableDatesModel>(
        error: true, errorMessage: response.errorMessage);
  return APIResponse<AvilableDatesModel>(
      data: AvilableDatesModel.fromJson(json: response.data));
}
