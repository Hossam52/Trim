import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/repositories/home_repo.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';

enum Search { Name, City, Both }

class SalonsCubit extends Cubit<SalonStates> {
  SalonsCubit() : super(InitialSalonState()) {
    loadData();
  }
  void loadData() async {
    await _loadAllSalonsForFirstTime(refreshPage: false);
    await _loadMostSearchedSalonsForFirstTime(refreshPage: false);
    await loadFavoriteSalons(refreshPage: false);
  }

  static SalonsCubit getInstance(BuildContext context) =>
      BlocProvider.of<SalonsCubit>(context);
  double totalPrice = 0;
  Search _search;
  String searchName = '';
  bool filterData = false;
  int selectedDateIndex = 0;
  int _currentPageAllSalonsIndex = 1;
  int _currentPageMostSearchedSalonsIndex = 1;
  int _currentPageFavoritesIndex = 1;
  int selectedCityId;
  List<List<Salon>> _allSalons =
      []; //every Index express of a page in all salons
  List<List<Salon>> _mostSearchSalons = [];
  List<List<Salon>> _favoriteSalons = [];

  Salon salonDetail;
  DateTime reservationDate = DateTime.now();
  List<String> availableDates = [];
  int salonIdToDisplay;

//--------------API Calls Start--------------

//At intiating the cubit will load all salons
  Future<void> _loadAllSalonsForFirstTime({@required refreshPage}) async {
    if (!refreshPage) emit(LoadingSalonState());
    final response = await loadAllSalonsFromServer(
      _currentPageAllSalonsIndex,
      body: _getAllSalonsBody(),
    );
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      if (_allSalons.isEmpty)
        _allSalons.add(response.data.allSalons);
      else if (refreshPage) {
        _allSalons[_currentPageAllSalonsIndex - 1] =
            response.data.allSalons; //update the current data o specific index
      }
      emit(LoadedSalonState());
    }
  }

//When scroll to the end of list we get more items
  Future<void> _loadMoreAllSalons({String name}) async {
    emit(LoadingMoreSalonState());
    final response = await loadAllSalonsFromServer(
        _currentPageAllSalonsIndex + 1,
        body: _getAllSalonsBody());
    if (response.error) {
      print(response.data.allSalons);
      emit(ErrorSalonState(error: response.errorMessage));
    } else {
      if (response.data.allSalons.isEmpty) {
        emit(NoMoreSalonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMoreSalonState());
      } else {
        _currentPageAllSalonsIndex++;
        _allSalons.add(response.data.allSalons);

        emit(LoadedMoreSalonState());
      }
    }
  }

//At intialing the cutbit will load most searched items from api
  Future<void> _loadMostSearchedSalonsForFirstTime(
      {@required refreshPage}) async {
    if (!refreshPage) emit(LoadingSalonState());
    final response =
        await loadHomeFromServer(_currentPageMostSearchedSalonsIndex);
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      if (_mostSearchSalons.isEmpty)
        _mostSearchSalons.add(response.data.mostSearchedSalons);
      else if (refreshPage) {
        _mostSearchSalons[_currentPageMostSearchedSalonsIndex - 1] =
            response.data.mostSearchedSalons;
      }
      emit(LoadedSalonState());
    }
  }

//when scroll to the end of the list of mostsearchitems
  Future<void> _loadMoreMostSearchedSalons() async {
    emit(LoadingMoreSalonState());
    final response =
        await loadHomeFromServer(_currentPageMostSearchedSalonsIndex + 1);
    if (response.error) {
      emit(ErrorSalonState(error: response.errorMessage));
    } else {
      if (response.data.mostSearchedSalons.isEmpty) {
        emit(NoMoreSalonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMoreSalonState());
      } else {
        _currentPageMostSearchedSalonsIndex++;
        _mostSearchSalons.add(response.data.mostSearchedSalons);
        emit(LoadedMoreSalonState());
      }
    }
  }

  Future<void> searchForSalon({String name, int cityId}) async {
    if ((name == null || name.isEmpty) && cityId != null)
      _search = Search.City;
    else if (name != null && cityId == null)
      _search = Search.Name;
    else if (name != null && cityId != null)
      _search = Search.City;
    else
      _search = Search.Both;
    searchName = name;
    selectedCityId = cityId;

    _currentPageAllSalonsIndex = 1;
    _allSalons.clear();

    if ((name == null || name.isEmpty) && cityId == null)
      filterData = false;
    else {
      filterData = true;
    }
    await _loadAllSalonsForFirstTime(refreshPage: false);
  }

  Future<void> getSalonDetails({@required int id}) async {
    emit(LoadingSalonDetailState());
    final response = await getSalonDetailFromServer(salonId: id);
    if (response.error)
      emit(ErrorSalonState(error: response.errorMessage));
    else {
      salonDetail = response.data.salon;
      print('length is ${salonDetail.salonServices.length}');
      totalPrice = 0;
      await getAvilableDates(DateTime.now());
      emit(LoadedSalonState());
    }
  }

  Future<void> getAvilableDates(DateTime date) async {
    reservationDate = date;
    print(DateFormat('y/MM/dd').format(reservationDate));
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

  Future<void> loadFavoriteSalons({@required bool refreshPage}) async {
    if (!refreshPage) emit(LoadingSalonState());
    final response =
        await loadFavoriteSalonsFromServer(_currentPageAllSalonsIndex);
    if (response.error) {
      emit(ErrorSalonState(error: response.errorMessage));
    } else {
      if (_favoriteSalons.isEmpty)
        _favoriteSalons.add(response.data.favoriteList);
      else if (refreshPage) {
        _favoriteSalons[_currentPageFavoritesIndex - 1] = response
            .data.favoriteList; //update the current data o specific index
      }
      emit(LoadedSalonState());
    }
  }

  Future<void> loadMoreFavoriteSalons() async {
    emit(LoadingMoreSalonState());
    final response =
        await loadFavoriteSalonsFromServer(_currentPageFavoritesIndex + 1);
    if (response.error) {
      emit(ErrorSalonState(error: response.errorMessage));
    } else {
      if (response.data.favoriteList.isEmpty) {
        emit(NoMoreSalonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMoreSalonState());
      } else {
        _currentPageFavoritesIndex++;
        _favoriteSalons.add(response.data.favoriteList);

        emit(LoadedMoreSalonState());
      }
    }
  }

  Future<void> addSalonToFavorite({@required int salonId}) async {
    _favoriteSalons.forEach((page) {
      int index = page.indexWhere((element) => element.id == salonId);
      if (index != -1) {
        page[index].isFavorite = !page[index].isFavorite;
      }
    });
    if (salonDetail != null && salonDetail.id == salonId) {
      salonDetail.isFavorite = !salonDetail.isFavorite;
    }
    emit(ChangeFavoriteState());

    await addToFavorite(salonId: salonId);

    loadFavoriteSalons(refreshPage: true); //To refresh data of favorite
  }

  Future<void> orderSalonWithServices(BuildContext context) async {
    emit(LoadingMakeOrderState());
    final response = await orderSalonServicesFromServer(
        salonDetail, reservationDate, availableDates[selectedDateIndex]);
    ReservationCubit.getInstance(context).loadMyOrders(refreshPage: true);
    emit(LoadedMakeOrderState());
  }

//--------------API Calls End ----------------
  Map<String, dynamic> _getAllSalonsBody() {
    Map<String, dynamic> body = {};
    if (filterData) {
      if (_search == Search.Name)
        body = {
          'name': searchName,
        };
      else if (_search == Search.City)
        body = {
          'city_id': selectedCityId,
        };
    }
    return body;
  }

  void getNextPage(BuildContext context) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState) {
      if (_currentPageAllSalonsIndex != _allSalons.length) {
        _currentPageAllSalonsIndex++;
        emit(LoadedMoreSalonState());
      } else {
        await _loadMoreAllSalons(name: searchName);
      }
    } else if (state is MostSearchState) {
      if (_currentPageMostSearchedSalonsIndex != _mostSearchSalons.length) {
        _currentPageMostSearchedSalonsIndex++;
        emit(LoadedMoreSalonState());
      } else {
        await _loadMoreMostSearchedSalons();
      }
    } else if (state is FavoriteState) {
      if (_currentPageFavoritesIndex != _favoriteSalons.length) {
        _currentPageFavoritesIndex++;
        emit(LoadedMoreSalonState());
      } else {
        await loadMoreFavoriteSalons();
      }
    }
  }

  void getPreviousPage(BuildContext context) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState) {
      if (_currentPageAllSalonsIndex != 1) {
        _currentPageAllSalonsIndex--;
        emit(LoadedSalonState());
      }
    } else if (state is MostSearchState) {
      if (_currentPageMostSearchedSalonsIndex != 1) {
        _currentPageMostSearchedSalonsIndex--;
        emit(LoadedSalonState());
      }
    } else if (state is FavoriteState) {
      if (_currentPageFavoritesIndex != 1) {
        _currentPageFavoritesIndex--;
        emit(LoadedSalonState());
      }
    }
  }

  int getCurrentPage(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      return _currentPageAllSalonsIndex;
    else if (state is MostSearchState)
      return _currentPageMostSearchedSalonsIndex;
    else if (state is FavoriteState) return _currentPageFavoritesIndex;
    return 0;
  }

  void navigateToSalonDetailScreen(BuildContext context, int salonId) {
    getSalonDetails(id: salonId);
    Navigator.pushNamed(context, DetailsScreen.routeName);
  }

  void changeSelectedReserveDate(int index) {
    selectedDateIndex = index;
    emit(ChangeSelecteTimeState());
  }

  int get getSelectedReserveTime {
    return selectedDateIndex;
  }

  Future<void> loadSalons(
      {@required bool refreshPage, @required BuildContext context}) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      await _loadAllSalonsForFirstTime(refreshPage: refreshPage);
    else if (state is MostSearchState)
      await _loadMostSearchedSalonsForFirstTime(refreshPage: refreshPage);
    else if (state is FavoriteState)
      await loadFavoriteSalons(refreshPage: refreshPage);
    else
      await _loadAllSalonsForFirstTime(refreshPage: refreshPage);
  }

  Future<void> loadMoreSalons(BuildContext context) async {
    getNextPage(context);
  }

  List<Salon> getSalonsToDisplay(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      return _allSalons.isEmpty
          ? []
          : _allSalons[_currentPageAllSalonsIndex - 1];
    else if (state is MostSearchState)
      return _mostSearchSalons.isEmpty
          ? []
          : _mostSearchSalons[_currentPageMostSearchedSalonsIndex - 1];
    else if (state is FavoriteState)
      return _favoriteSalons.isEmpty
          ? []
          : _favoriteSalons[_currentPageFavoritesIndex - 1];
    else
      return _allSalons.isEmpty
          ? []
          : _allSalons[_currentPageAllSalonsIndex - 1];
  }

  void toggelSelectedService(int serviceId) {
    int index = salonDetail.salonServices
        .indexWhere((element) => element.id == serviceId);
    if (index != -1) {
      double servicePrice =
          double.tryParse(salonDetail.salonServices[index].price);

      if (salonDetail.salonServices[index].selected)
        totalPrice -= servicePrice ?? 0;
      else
        totalPrice += servicePrice ?? 0;
      print(totalPrice);
      salonDetail.salonServices[index].selected =
          !salonDetail.salonServices[index].selected;
      emit(ToggleSelectedServiceState());
    }
  }

  bool canReserveSalon() {
    if (totalPrice != 0 &&
        availableDates.isNotEmpty &&
        state is! LoadingAvilableDatesState) {
      return true;
    }
    return false;
  }
}
