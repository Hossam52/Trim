import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/home_model.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/modules/home/models/all_salons_model.dart';
import 'package:trim/api_reponse.dart';
import '../models/all_persons_model.dart';
import '../models/salon_model.dart';
import 'package:trim/utils/services/call_api.dart';
import '../models/available_dates_model.dart';
import '../models/favorites_model.dart';
import '../models/cities_model.dart';

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

Future<APIResponse<AllPersonsModel>> loadAllPersonsFromServer(int pageCount,
    {Map<String, dynamic> body = const {}}) async {
  final recievedData = await callAPI(allPersonsUrl,
      quiries: {'page': pageCount}, body: body, callType: CallType.Post);
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

Future<APIResponse<FavoritesModel>> loadFavoriteSalonsFromServer(
    int pageCount) async {
  final recievedData = await callAPI(favoriteSalonsUrl,
      quiries: {'page': pageCount}, callType: CallType.Get);
  print(recievedData.data);
  if (recievedData.error)
    return APIResponse<FavoritesModel>(
        error: true, errorMessage: recievedData.errorMessage);
  else
    return APIResponse<FavoritesModel>(
        data: FavoritesModel.fromJson(json: recievedData.data));
}

Future<APIResponse<FavoritesModel>> loadFavoritePersonsFromServer(
    int pageCount) async {
  final recievedData = await callAPI(favoritePersonsUrl,
      quiries: {'page': pageCount}, callType: CallType.Get);
  if (recievedData.error)
    return APIResponse<FavoritesModel>(
        error: true, errorMessage: recievedData.errorMessage);
  else
    return APIResponse<FavoritesModel>(
        data: FavoritesModel.fromJson(json: recievedData.data));
}

Future<APIResponse<String>> addToFavorite({@required int salonId}) async {
  final response = await callAPI(addToFavoriteUrl,
      body: {'salon_id': salonId}, callType: CallType.Post);
  if (response.error) {
    return APIResponse<String>(
        error: true, errorMessage: response.errorMessage);
  } else
    return APIResponse<String>(data: response.data['message']);
}

Future<APIResponse<Cities>> loadAllCitiesFromServer() async {
  final response = await callAPI(citiesUrl, callType: CallType.Get);
  if (response.error) {
    return APIResponse(error: true, errorMessage: response.errorMessage);
  }
  return APIResponse<Cities>(data: Cities.fromJson(json: response.data));
}

Future<APIResponse<bool>> orderSalonServicesFromServer(
    {Salon salon,
    DateTime reservationDate,
    String reservationTime,
    String paymentMethod,
    paymentCopon}) async {
  final int salonId = salon.id;
  final services =
      salon.salonServices.where((service) => service.selected).toList();
  final barberType = 'salon';
  final reservationDay = DateFormat('y/MM/dd').format(reservationDate);
  final List<Map<String, dynamic>> servicesMap =
      services.map((service) => service.toJson()).toList();
  final requestBody = {
    'services': servicesMap,
    'barber_id': salonId,
    'barber_type': barberType,
    'reservation_day': reservationDay,
    'reservation_time': reservationTime,
    'payment_method': paymentMethod,
  };
  if (paymentCopon != null) requestBody['payment_coupon'] = paymentCopon;
  final response = await callAPI(orderSalonServiceUrl,
      body: requestBody, callType: CallType.Post);
  if (response.error)
    return APIResponse(error: true, errorMessage: response.errorMessage);
  else
    return APIResponse(data: true);
}

Future<APIResponse<AllSalonsModel>> getNearestSalonsFromServer(
    double latitude, double longtiude) async {
  final response = await callAPI(nearestSalonsUrl,
      body: {'lat': latitude, 'lng': longtiude}, callType: CallType.Post);
  if (response.error) {
    return APIResponse(error: true, errorMessage: response.errorMessage);
  } else {
    print(response.data);
    return APIResponse<AllSalonsModel>(
        data: AllSalonsModel.fromJson(json: response.data));
  }
}
