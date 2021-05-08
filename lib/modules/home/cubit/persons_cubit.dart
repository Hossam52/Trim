import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/person_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/repositories/home_repo.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';

enum _PersonDisplayType {
  AllPersons,
  StarPersons,
}

class PersonsCubit extends Cubit<PersonStates> {
  PersonsCubit() : super(IntialPersonsState()) {
    _loadAllPersons(refreshPage: false);
    _loadTrimStars(refreshPage: false);
  }

  _PersonDisplayType personDisplayType = _PersonDisplayType.AllPersons;

  // Temp whatToDisplay = temp;
  int _allPersonsPageCount = 1;
  int _trimStarsPageCount = 1;
  static PersonsCubit getInstance(BuildContext context) =>
      BlocProvider.of<PersonsCubit>(context);
  List<Salon> _allPersons = [];
  List<Salon> _starsPersons = [];

//----------------API Calls Start-------------
  Future<void> _loadAllPersons({@required bool refreshPage}) async {
    if (!refreshPage) emit(LoadingPersonsState());
    final response = await loadAllPersonsFromServer(_allPersonsPageCount);
    if (response.error) {
      emit(ErrorPersonsState(error: response.errorMessage));
    } else {
      if (_allPersons.isEmpty)
        _allPersons = response.data.allPersons;
      else if (refreshPage) {
        final recievedList = response.data.allPersons;
        if (recievedList[recievedList.length - 1].id !=
            _allPersons[_allPersons.length - 1].id) {
          _allPersons.addAll(response.data.allPersons);
        }
      }
      emit(LoadedPersonsState());
    }
  }

  Future<void> _loadMoreAllPersons() async {
    emit(LoadingMorePersonState());
    final response = await loadAllPersonsFromServer(_allPersonsPageCount + 1);
    if (response.error) {
      print(response.data.allPersons);
      emit(ErrorMorePersonState(error: response.errorMessage));
    } else {
      if (response.data.allPersons.isEmpty) {
        emit(NoMorePersonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMorePersonState());
      } else {
        _allPersonsPageCount++;
        _allPersons.addAll(response.data.allPersons);
        emit(LoadedMorePersonState());
      }
    }
  }

  Future<void> _loadTrimStars({bool refreshPage}) async {
    if (!refreshPage) emit(LoadingPersonsState());
    final response = await loadHomeFromServer(_trimStarsPageCount);
    if (response.error) {
      print(response.errorMessage);
      emit(ErrorPersonsState(error: response.errorMessage));
    } else {
      if (response.data.trimStars.isEmpty) {
        emit(EmptyPersonListState());
      } else {
        if (_starsPersons.isEmpty)
          _starsPersons = response.data.trimStars;
        else if (refreshPage) {
          final recievedList = response.data.trimStars;
          if (recievedList[recievedList.length - 1].id !=
              _starsPersons[_starsPersons.length - 1].id) {
            //Check if the last index of the recieved list from api is not the last index of displayed persons then add the recieved list to the current list
            _starsPersons.addAll(response.data.trimStars);
          }
        }
        emit(LoadedMorePersonState());
      }
    }
  }

  Future<void> _loadMoreTrimStars() async {
    emit(LoadingMorePersonState());
    final response = await loadHomeFromServer(_trimStarsPageCount + 1);
    if (response.error) {
      print(response.errorMessage);
      emit(ErrorMorePersonState(error: response.errorMessage));
    } else {
      print(_trimStarsPageCount);
      if (response.data.trimStars.isEmpty) {
        emit(NoMorePersonState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedMorePersonState());
      } else {
        _trimStarsPageCount++;
        _starsPersons.addAll(response.data.trimStars);
        emit(LoadedMorePersonState());
      }
    }
  }

//-----------------API Calls End-------------
  List<Salon> getPersonToDisplay(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      return _allPersons;
    else if (state is TrimStarState)
      return _starsPersons;
    else if (state is FavoriteSalonsState)
      return _allPersons;
    else
      return _allPersons;
    // whatToDisplay = temp;
    // print(_allPersons);
    // if (temp == Temp.All)
    //   return _allPersons;
    // else if (temp == Temp.Home)
    //   return _starsPersons;
    // else if (temp == Temp.Favorites)
    //   return _allPersons;
    // else
    //   return _allPersons;
  }

  Future<void> loadAllPersons(BuildContext context,
      {@required bool refreshPage}) async {
    final state = HomeCubit.getInstance(context).state;
    if (state is AllSalonsState)
      await _loadAllPersons(refreshPage: refreshPage);
    else if (state is TrimStarState)
      await _loadTrimStars(refreshPage: refreshPage);
    else if (state is FavoriteSalonsState)
      await _loadTrimStars(refreshPage: refreshPage);

    // if (whatToDisplay == Temp.All) {
    //   await _loadAllPersons(refreshPage: refreshPage);
    // } else if (whatToDisplay == Temp.Home) {
    //   await _loadTrimStars(refreshPage: refreshPage);
    // }
  }

  Future<void> loadMorePersons(BuildContext context) async {
    // if (whatToDisplay == Temp.All)
    //   return await _loadMoreAllPersons();
    // else if (whatToDisplay == Temp.Home)
    //   return await _loadMoreTrimStars();
    // else if (whatToDisplay == Temp.Favorites) return _allPersons;
    final state = HomeCubit.getInstance(context).state;
    print(state);
    if (state is AllSalonsState)
      await _loadMoreAllPersons();
    else if (state is TrimStarState)
      await _loadMoreTrimStars();
    else if (state is FavoriteSalonsState)
      await _loadMoreAllPersons();
    else
      await _loadMoreAllPersons();
  }
}
