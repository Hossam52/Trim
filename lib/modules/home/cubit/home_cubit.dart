import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/models/trim_star_model.dart';
import 'package:trim/modules/home/repositories/home_repo.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/market/screens/ShoppingScreen.dart';
import 'package:trim/modules/settings/screens/favourties_screen.dart';
import 'package:trim/modules/settings/screens/settings_screen.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/modules/home/models/home_model.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(LoadingHomeState());
  static HomeCubit getInstance(BuildContext context) =>
      BlocProvider.of<HomeCubit>(context);

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

  Future<void> getTrimStarProfile(int id) {}

//-------------------------API Calls End-------------------
  Future<bool> canUseLocationServices() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //Enable location from mbile
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return Future.value(true);
  }

  Future<Position> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //Enable location from mbile
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
