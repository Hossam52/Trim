import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/repositories/home_repo.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/settings/screens/favourties_screen.dart';
import 'package:trim/modules/home/models/home_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(LoadingHomeState());
  static HomeCubit getInstance(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);
  @override
  Future<void> close() {
    super.close();
    return Future.value();
  }

  //Fields
  HomeModel homeModel;
  List<PageWidget> pagesBuilder = [];

  Salon selectedMostSearchItem;

  //Methods
  List<Salon> get mostSearchedSalons {
    return homeModel.mostSearchedSalons;
  }

  List<Salon> get trimStarList {
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
    emit(TrimStarState());
    Navigator.pushNamed(
      context,
      SalonsScreen.routeName,
    );
  }

  void navigateToMostSearch(BuildContext context) {
    emit(MostSearchState());

    Navigator.pushNamed(context, SalonsScreen.routeName);
  }

  void navigateToFavoriets(BuildContext context) async {
    emit(FavoriteState());

    Navigator.pushNamed(context, FavouritesScreen.routeName);
  }

//-------------------------API Calls Start-----------------
  void loadHomeLayout(BuildContext context) async {
    emit(LoadingHomeState());
    final response = await loadHomeFromServer(1);
    if (response.error) {
      print(response.errorMessage);
      emit(ErrorHomeState(error: response.errorMessage));
    } else {
      homeModel = response.data;
      emit(SuccessHomeState());
    }
  }

//-------------------------API Calls End-------------------
}
