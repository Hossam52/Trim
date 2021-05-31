import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/market/cubit/categories_events.dart';
import 'package:trim/modules/market/cubit/categories_states.dart';
import 'package:trim/modules/market/models/Category.dart';

import '../../../utils/services/rest_api_service.dart';

class AllCategoriesBloc extends Bloc<CategoriesEvents, CategoriesStates> {
  AllCategoriesBloc() : super(InitialState());
  List<Category> categories;
  @override
  Stream<CategoriesStates> mapEventToState(CategoriesEvents event) async* {
    categories = [];
    var response;
    var body;
    yield InitialState();
    try {
      if (event is CategoriesFetchDataFromApi) {
        yield LoadingState();
        response = await DioHelper.postData(url: allCategoriesUrl, body: {});
        body = response.data['data'];
        for (var category in body) {
          categories.add(Category.fromjson(category));
        }
        yield LoadedState(categories);
      } else if (event is SearchedCategories) {
        yield LoadingState();
        response = await DioHelper.postData(url: allCategoriesUrl, body: {
          'name': event.searchedWord,
        });
        body = response.data['data'];
        for (var category in body) {
          categories.add(Category.fromjson(category));
        }
        yield LoadedState(categories);
      }
    } catch (e) {
      yield ErrorStateCategories();
    }
  }
}
