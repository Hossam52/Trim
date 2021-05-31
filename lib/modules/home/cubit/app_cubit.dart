import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/auth/models/token_model.dart';
import 'package:trim/modules/home/cubit/app_states.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/services/sercure_storage_service.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(IntialAppState());
  String name = '';
  String email = '';
  String image = '';
  String cover = '';
  String phone = '';
  int shippingFee = 30;
  static AppCubit getInstance(context) => BlocProvider.of<AppCubit>(context);
  Future<void> intializeDio(String token) async {
    if (token != null) {
      await extractUserProfileData();
      DioHelper.init(accessToken: 'Bearer $token');
    } else
      DioHelper.init(accessToken: null);
  }

  Future<void> extractUserProfileData() async {
    name = await TrimShared.getDataFromShared('name');
    email = await TrimShared.getDataFromShared('email');
    phone = await TrimShared.getDataFromShared('phone');
    image = await TrimShared.getDataFromShared('image');
    cover = await TrimShared.getDataFromShared('cover');
  }

  Future<void> reloadData(context) async {
    emit(ReloadDataState());
  }

  void updateInfo(Map<String, dynamic> userData) async {
    TokenModel tokenModel = TokenModel.fromJson(
      json: {
        'token': await TrimShared.getDataFromShared('token'),
        'user': userData
      },
    );
    await TrimShared.storeProfileData(tokenModel);
    await extractUserProfileData();
    emit(ChangedUserDataState());
  }
}
