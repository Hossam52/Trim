import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/models/trim_star_model.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/modules/home/models/home_model.dart';

enum DisplayType { AllSalons, Persons, MostSearch }

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(LoadingHomeState());
  static HomeCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);

  //Fields

  HomeModel homeModel;
  DisplayType _displayType = DisplayType.AllSalons;

  //Methods
  List<Salon> get mostSearchList {
    return homeModel.mostSearchedSalons;
  }

  void setDisplayType(DisplayType type) {
    _displayType = type;
  }

  DisplayType get getDisplayType {
    return _displayType;
  }

  List<TrimStarModel> get trimStarList {
    return homeModel.trimStars;
  }

  List<SalonOffer> get _lastOffers {
    return homeModel.lastOffers;
  }

  int get lastSalonOffersLength {
    return _lastOffers.length;
  }

  SalonOffer getlastOfferItem(int index) {
    return _lastOffers[index];
  }

  void navigateToTrimStars(BuildContext context) {
    setDisplayType(DisplayType.Persons);
    Navigator.pushNamed(
      context,
      SalonsScreen.routeName,
    );
  }

  void navigateToMostSearch(BuildContext context) {
    HomeCubit.getInstance(context).setDisplayType(DisplayType.MostSearch);

    Navigator.pushNamed(context, SalonsScreen.routeName);
  }

  void getData() async {
    emit(LoadingHomeState());

    final response = await DioHelper.getData(methodUrl: homeUrl, queries: {});
    homeModel = HomeModel.fromJson(json: response.data);
    emit(SuccessHomeState());
  }
}
