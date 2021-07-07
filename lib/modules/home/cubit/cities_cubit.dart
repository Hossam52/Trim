import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/cities_states.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import '../models/cities_model.dart';

class CitiesCubit extends Cubit<CitiesStates> {
  CitiesCubit() : super(IntialReserveState()) {
    getAllCities();
  }

  static CitiesCubit getInstance(context) => BlocProvider.of(context);

  List<CityModel> cities = [];
  CityModel selectedCity;
  Future<void> getAllCities() async {
    emit(LoadingCitiesState());
    final response = await loadAllCitiesFromServer();
    if (response.error) {
      emit(ErrorCitiesState(response.errorMessage));
    } else {
      if (response.data.cities.isEmpty)
        emit(EmptyCitiesState());
      else {
        cities.add(CityModel(id: null, nameEnglish: 'All', nameArabic: 'الكل'));

        response.data.cities.forEach((city) {
          print('${city.id}  ${city.nameEn}');
          cities.add(city);
        });
        selectedCity = cities[0];
        emit(LoadedCitiesState());
      }
    }
  }

  void changeSelecteCity(CityModel city) {
    selectedCity = city;
    emit(ChangeSelectedCity());
  }
}
