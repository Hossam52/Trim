import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/repositories/home_repo.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import 'package:trim/modules/home/screens/details_screen.dart';

class SalonsCubit extends Cubit<SalonStates> {
  SalonsCubit() : super(InitialSalonState()) {
    _loadAllSalonsForFirstTime(refreshPage: false);
    _loadMostSearchedSalonsForFirstTime(refreshPage: false);
  }
  static SalonsCubit getInstance(BuildContext context) =>
      BlocProvider.of<SalonsCubit>(context);
  int _allSalonsPageCount = 1;
  int _mostSearchedSalonsPageCount = 1;
  int _selectedDateIndex = 0;

  List<Salon> _allSalons = [];
  List<Salon> _mostSearchSalons = [];

  Salon salonDetail;
  List<String> availableDates = [];
  int salonIdToDisplay;
  DateTime _selectedDate = DateTime.now();

//--------------API Calls Start--------------

//At intiating the cubit will load all salons
  Future<void> _loadAllSalonsForFirstTime({@required refreshPage}) async {
    if (!refreshPage) emit(LoadingSalonState());
    final response = await loadAllSalonsFromServer(_allSalonsPageCount);
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      if (_allSalons.isEmpty)
        _allSalons = response.data.allSalons;
      else if (refreshPage) {
        final recievedList = response.data.allSalons;
        if (recievedList[recievedList.length - 1].id !=
            _allSalons[_allSalons.length - 1].id) {
          _allSalons.addAll(response.data.allSalons);
        }
      }
      emit(LoadedSalonState());
    }
  }

//When scroll to the end of list we get more items
  Future<void> _loadMoreAllSalons() async {
    emit(LoadingMoreSalonState());
    final response = await loadAllSalonsFromServer(_allSalonsPageCount + 1);
    if (response.error) {
      print(response.data.allSalons);
      emit(ErrorSalonState(error: response.errorMessage));
    } else {
      if (response.data.allSalons.isEmpty) {
        emit(NoMoreSalonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMoreSalonState());
      } else {
        _allSalonsPageCount++;
        _allSalons.addAll(response.data.allSalons);
        emit(LoadedMoreSalonState());
      }
    }
  }

//At intialing the cutbit will load most searched items from api
  Future<void> _loadMostSearchedSalonsForFirstTime(
      {@required refreshPage}) async {
    if (!refreshPage) emit(LoadingSalonState());
    final response = await loadHomeFromServer(_mostSearchedSalonsPageCount);
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      if (_mostSearchSalons.isEmpty)
        _mostSearchSalons = response.data.mostSearchedSalons;
      else if (refreshPage) {
        final recievedList = response.data.mostSearchedSalons;
        if (recievedList[recievedList.length - 1].id !=
            _mostSearchSalons[_mostSearchSalons.length - 1].id) {
          _mostSearchSalons.addAll(response.data.mostSearchedSalons);
        }
      }
      emit(LoadedSalonState());
    }
  }

//when scroll to the end of the list of mostsearchitems
  Future<void> _loadMoreMostSearchedSalons() async {
    emit(LoadingMoreSalonState());
    final response = await loadHomeFromServer(_mostSearchedSalonsPageCount + 1);
    if (response.error) {
      emit(ErrorSalonState(error: response.errorMessage));
    } else {
      if (response.data.mostSearchedSalons.isEmpty) {
        emit(NoMoreSalonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMoreSalonState());
      } else {
        _mostSearchedSalonsPageCount++;
        print(_mostSearchSalons.length);
        _mostSearchSalons.addAll(response.data.mostSearchedSalons);

        print(_mostSearchSalons.length);
        emit(LoadedMoreSalonState());
      }
    }
  }

  Future<void> searchSalonsByName(String name) async {
    emit(LoadingSalonState());
    final response = await loadAllSalonsFromServer(_allSalonsPageCount,
        body: {'name': name});
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      // print(response.data.allSalons);
      _allSalons = response.data.allSalons;
    }
    emit(LoadedSalonState());
  }

  Future<void> _getAllCities() {}

  Future<void> getSalonDetails({@required int id}) async {
    emit(LoadingSalonDetailState());
    final response = await getSalonDetailFromServer(salonId: id);
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      salonDetail = response.data.salon;
      await getAvilableDates(DateTime.now());
      emit(LoadedSalonState());
    }
  }

  Future<void> getAvilableDates(DateTime date) async {
    emit(LoadingAvilableDatesState());
    final response =
        await getAvailableDatesFromServer(id: salonDetail.id, date: date);
    if (!response.error) {
      availableDates = response.data.avilableDates;
      print(availableDates);
      changeSelectedReserveDate(0);
      if (availableDates.isEmpty)
        emit(EmptyAvialbleDatesState());
      else
        emit(LoadedSalonState());
    } else
      emit(ErrorAvilableDatesState());
  }

//--------------API Calls End ----------------

  void navigateToSalonDetailScreen(BuildContext context, int salonId) {
    getSalonDetails(id: salonId);
    Navigator.pushNamed(context, DetailsScreen.routeName);
  }

  void changeSelectedReserveDate(int index) {
    _selectedDateIndex = index;
    emit(ChangeSelecteTimeState());
  }

  int get getSelectedReserveTime {
    return _selectedDateIndex;
  }

  void changeSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    emit(ChangeSelectedDateState());
  }

//
  Future<void> loadSalons(
      {@required bool refreshPage, @required BuildContext context}) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      await _loadAllSalonsForFirstTime(refreshPage: refreshPage);
    else if (state is MostSearchState)
      await _loadMostSearchedSalonsForFirstTime(refreshPage: refreshPage);
    else if (state is FavoriteSalonsState)
      await _loadAllSalonsForFirstTime(refreshPage: refreshPage);
    else
      await _loadAllSalonsForFirstTime(refreshPage: refreshPage);
  }

  Future<void> loadMoreSalons(BuildContext context) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      await _loadMoreAllSalons();
    else if (state is MostSearchState)
      await _loadMoreMostSearchedSalons();
    else if (state is FavoriteSalonsState)
      await _loadMoreAllSalons();
    else
      await _loadMoreAllSalons();
  }

  List<Salon> getSalonsToDisplay(BuildContext context) {
    // whatToDisplay = temp;
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      return _allSalons;
    else if (state is MostSearchState)
      return _mostSearchSalons;
    else if (state is FavoriteSalonsState)
      return _allSalons;
    else
      return _allSalons;
  }
}
