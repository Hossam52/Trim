import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/home/models/category_products.dart';
import 'package:trim/modules/market/cubit/categories_states.dart';
import 'package:trim/modules/market/models/Category.dart';

import '../../../utils/services/rest_api_service.dart';

class AllcategoriesCubit extends Cubit<CategoriesStates> {
  AllcategoriesCubit() : super(InitialState()) {
    getData();
  }
  static AllcategoriesCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);
  Future<void> getData() async {
    try {
      emit(LoadingState());
      final response =
          await DioHelper.postData(url: allCategoriesUrl, body: {});
      print('Error in Categories');
      print(response.statusCode);
      var body = response.data['data'];
      print(body);
      print('lenght\n');
      print(body.length);
      List<Category> categories = [];
      for (var category in body) {
        print(category);
        categories.add(Category.fromjson(category));
      }
      emit(LoadedState(categories));
    } catch (e) {
      //   DioErrorType.connectTimeout;
      print(e.toString());
      emit(ErrorStateCategories());
    }
  }
}
