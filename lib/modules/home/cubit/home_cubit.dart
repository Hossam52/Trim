import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/modules/home/models/home_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(LoadingHomeState());
  static HomeCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);

  HomeModel homeModel;

  List<Salon> get mostSearchList {
    return homeModel.mostSearchedSalons;
  }

  void getData() async {
    emit(LoadingHomeState());

    final response = await DioHelper.getData(methodUrl: homeUrl, queries: {});
    homeModel = HomeModel.fromJson(json: response.data);

    emit(SuccessHomeState());
  }
}
