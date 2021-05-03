import 'dart:convert';

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
  void getData() async {
    try {
      emit(LoadingState());
      final response =
          await DioHelper.postData(url: allCategoriesUrl, body: {});
      print('error here');
      print(response.statusCode);
      //     if(response.statusCode<400)
      var body = response.data['data'];
      print(body);
      print('lenght\n');
      print(body.length);
      List<Category> categories=[];
      for (var category in body) {
        print(category);
        categories.add(Category.fromjson(category));
      }
      emit(LoadedState(categories));
    } catch (e) {
      print(e.toString());
      emit(ErrorState());
    }
  }
}
