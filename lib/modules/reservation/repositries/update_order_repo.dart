import 'package:http/http.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/models/salon_model.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import 'package:trim/utils/services/call_api.dart';

Future<APIResponse<bool>> updateOrderFromServer(
    Map<String, dynamic> body) async {
  final res =
      await callAPI(updateOrderUrl, callType: CallType.Post, body: body);
  if (res.error)
    return APIResponse(error: true, errorMessage: res.errorMessage);
  return APIResponse<bool>(data: true);
}

Future<APIResponse<SalonModel>> getSalonProfileFromServer(int salonId) async {
  return getSalonDetailFromServer(salonId: salonId);
}
