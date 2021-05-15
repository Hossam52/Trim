import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/person_states.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/repositories/home_repo.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';

class PersonsCubit extends Cubit<PersonStates> {
  PersonsCubit() : super(IntialPersonsState()) {
    loadData();
  }
  void loadData() async {
    await _loadAllPersons(refreshPage: false);
    await _loadTrimStars(refreshPage: false);
    await loadFavoritePersons(refreshPage: false);
  }

  Search _search;

  String searchName = '';
  int _currentAllPersonsPage = 1;
  int _currentStarsPage = 1;
  int _currentFavoritePersons = 1;
  bool filterData = false;
  int selectedCityId;

  static PersonsCubit getInstance(BuildContext context) =>
      BlocProvider.of<PersonsCubit>(context);
  List<List<Salon>> _allPersons = [];
  List<List<Salon>> _starsPersons = [];
  List<List<Salon>> _favoritePersons = [];

//----------------API Calls Start-------------
  Future<void> _loadAllPersons({@required bool refreshPage}) async {
    if (!refreshPage) emit(LoadingPersonsState());
    final response = await loadAllPersonsFromServer(_currentAllPersonsPage,
        body: _getAllPersonsBody());
    if (response.error) {
      emit(ErrorPersonsState(error: response.errorMessage));
    } else {
      if (_allPersons.isEmpty)
        _allPersons.add(response.data.allPersons);
      else if (refreshPage) {
        _allPersons[_currentAllPersonsPage - 1] = response.data.allPersons;
      }
      emit(LoadedPersonsState());
    }
  }

  Future<void> _loadMoreAllPersons() async {
    emit(LoadingMorePersonState());
    final response = await loadAllPersonsFromServer(_currentAllPersonsPage + 1,
        body: _getAllPersonsBody());
    if (response.error) {
      print(response.data.allPersons);
      emit(ErrorMorePersonState(error: response.errorMessage));
    } else {
      if (response.data.allPersons.isEmpty) {
        emit(NoMorePersonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMorePersonState());
      } else {
        _currentAllPersonsPage++;
        _allPersons.add(response.data.allPersons);
        emit(LoadedMorePersonState());
      }
    }
  }

  Future<void> _loadTrimStars({bool refreshPage}) async {
    if (!refreshPage) emit(LoadingPersonsState());
    final response = await loadHomeFromServer(_currentStarsPage);
    if (response.error) {
      print(response.errorMessage);
      emit(ErrorPersonsState(error: response.errorMessage));
    } else {
      if (response.data.trimStars.isEmpty) {
        emit(EmptyPersonListState());
      } else {
        if (_starsPersons.isEmpty)
          _starsPersons.add(response.data.trimStars);
        else if (refreshPage) {
          _starsPersons[_currentStarsPage - 1] = response.data.trimStars;
        }
        emit(LoadedPersonsState());
      }
    }
  }

  Future<void> _loadMoreTrimStars() async {
    emit(LoadingMorePersonState());
    final response = await loadHomeFromServer(_currentStarsPage + 1);
    if (response.error) {
      print(response.errorMessage);
      emit(ErrorMorePersonState(error: response.errorMessage));
    } else {
      if (response.data.trimStars.isEmpty) {
        emit(NoMorePersonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMorePersonState());
      } else {
        _currentStarsPage++;
        _starsPersons.add(response.data.trimStars);
        emit(LoadedMorePersonState());
      }
    }
  }

  Future<void> loadFavoritePersons({@required bool refreshPage}) async {
    if (!refreshPage) emit(LoadingPersonsState());
    final response =
        await loadFavoritePersonsFromServer(_currentFavoritePersons);
    if (response.error) {
      emit(ErrorPersonsState(error: response.errorMessage));
    } else {
      if (_favoritePersons.isEmpty)
        _favoritePersons.add(response.data.favoriteList);
      else if (refreshPage) {
        _favoritePersons[_currentFavoritePersons - 1] =
            response.data.favoriteList;
      }
      emit(LoadedPersonsState());
    }
  }

  Future<void> loadMoreFavoritePersons() async {
    emit(LoadingMorePersonState());
    final response =
        await loadFavoritePersonsFromServer(_currentFavoritePersons + 1);
    if (response.error) {
      emit(ErrorMorePersonState(error: response.errorMessage));
    } else {
      if (response.data.favoriteList.isEmpty) {
        emit(NoMorePersonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMorePersonState());
      } else {
        _currentFavoritePersons++;
        _favoritePersons.add(response.data.favoriteList);
        emit(LoadedMorePersonState());
      }
    }
  }

  Future<void> searchForPerson({String name, int cityId}) async {
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

    _currentAllPersonsPage = 1;
    _allPersons.clear();

    if ((name == null || name.isEmpty) && cityId == null)
      filterData = false;
    else {
      filterData = true;
    }
    await _loadAllPersons(refreshPage: false);
  }

//-----------------API Calls End-------------
  Map<String, dynamic> _getAllPersonsBody() {
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

  List<Salon> getPersonToDisplay(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllPersonsState)
      return _allPersons[_currentAllPersonsPage - 1];
    else if (state is TrimStarState)
      return _starsPersons[_currentStarsPage - 1];
    else if (state is FavoriteState)
      return _favoritePersons[_currentFavoritePersons - 1];
    else
      return _allPersons[_currentAllPersonsPage - 1];
  }

  void getNextPage(BuildContext context) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllPersonsState) {
      if (_currentAllPersonsPage != _allPersons.length) {
        _currentAllPersonsPage++;
        emit(LoadedPersonsState());
      } else {
        await _loadMoreAllPersons();
      }
    } else if (state is TrimStarState) {
      if (_currentStarsPage != _starsPersons.length) {
        _currentStarsPage++;
        emit(LoadedMorePersonState());
      } else {
        await _loadMoreTrimStars();
      }
    } else if (state is FavoriteState) {
      print('$_currentFavoritePersons');
      if (_currentFavoritePersons != _favoritePersons.length) {
        _currentFavoritePersons++;
        emit(LoadedMorePersonState());
      } else {
        await loadMoreFavoritePersons();
      }
    }
  }

  void getPreviousPage(BuildContext context) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllPersonsState) {
      if (_currentAllPersonsPage != 1) {
        _currentAllPersonsPage--;
        emit(LoadedPersonsState());
      }
    } else if (state is TrimStarState) {
      if (_currentStarsPage != 1) {
        _currentStarsPage--;
        emit(LoadedPersonsState());
      }
    } else if (state is FavoriteState) {
      if (_currentFavoritePersons != 1) {
        _currentFavoritePersons--;
        emit(LoadedPersonsState());
      }
    }
  }

  int getCurrentPage(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllPersonsState)
      return _currentAllPersonsPage;
    else if (state is TrimStarState)
      return _currentStarsPage;
    else if (state is FavoriteState) return _currentFavoritePersons;
    return 0;
  }

  Future<void> loadAllPersons(BuildContext context,
      {@required bool refreshPage}) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllPersonsState)
      await _loadAllPersons(refreshPage: refreshPage);
    else if (state is TrimStarState)
      await _loadTrimStars(refreshPage: refreshPage);
    else if (state is FavoriteState)
      await loadFavoritePersons(refreshPage: refreshPage);
  }

  Future<void> loadMorePersons(BuildContext context) async {
    getNextPage(context);
  }
}
