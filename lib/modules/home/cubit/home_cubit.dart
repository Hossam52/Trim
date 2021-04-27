import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/home_states.dart';

class OffersCubit extends Cubit<HomeStates> {
  OffersCubit() : super(LoadingOffersState());

  static OffersCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);

  void getOffers() async {
    print('before offers');
    emit(LoadingOffersState());
    print('after offers');
    await Future.delayed(Duration(seconds: 10));
    // print('Finished offers');
    emit(SuccessOffersState());
  }
}

class MostSearchCubit extends Cubit<HomeStates> {
  MostSearchCubit() : super(LoadingMostSearchState());
  static MostSearchCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);
  void getMostSearcSalons() async {
    print('before mostsearch');
    emit(LoadingMostSearchState());

    print('after mosstsearch');
    await Future.delayed(Duration(seconds: 7));
    // print('Finished most search');
    emit(SuccessMostSearchState());
  }
}

class TrimStarsCubit extends Cubit<HomeStates> {
  TrimStarsCubit() : super(LoadingTrimStarsState());
  static TrimStarsCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);
  void getTrimStars() async {
    print('before stars');
    emit(LoadingTrimStarsState());

    print('after stars');
    await Future.delayed(Duration(seconds: 8));
    // print('Finished trim stars');
    emit(SuccessTrimStarsState());
  }
}
