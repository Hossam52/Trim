import 'package:trim/api_reponse.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/models/home_model.dart';
import 'package:trim/utils/services/call_api.dart';

Future<APIResponse<HomeModel>> loadHomeFromServer(int page) async {
  final response =
      await callAPI(homeUrl, quiries: {'page': page}, callType: CallType.Get);
  if (response.error)
    return APIResponse<HomeModel>(
        error: true, errorMessage: response.errorMessage);
  return APIResponse<HomeModel>(data: HomeModel.fromJson(json: response.data));
}
