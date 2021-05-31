import 'package:dio/dio.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/market/cubit/procucts_category_states.dart';
import 'package:trim/modules/market/cubit/products_category_events.dart';
import 'package:trim/modules/market/models/Product.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCategoryCubit extends Cubit<ProductsCategoryStates> {
  ProductsCategoryCubit() : super(InitialState());
  List<Product> products = [];
  void getData(int categoryId) async {
    try {
      emit(LoadingStateProductsCategory());
      await DioHelper.postData(
          url: '$productsCategoryUrl?category_id=$categoryId', body: {});
      emit(LoadedStateProductsCategory());
    } catch (e) {
      emit(ErrorStateProductsCategory());
    }
  }
}

class ProductsCategoryBloc
    extends Bloc<ProductsCategoryEvents, ProductsCategoryStates> {
  ProductsCategoryBloc() : super(InitialState());
  List<Product> products;
  List<Product> searchedProducts;
  @override
  Stream<ProductsCategoryStates> mapEventToState(
      ProductsCategoryEvents event) async* {
    try {
      products = [];
      var body;
      yield LoadingStateProductsCategory();
      Response response;
      if (event is FetchDataFromApi) {
        response = await DioHelper.postData(
            url: '$productsCategoryUrl?category_id=${event.categoryId}',
            body: {});
        yield LoadedStateProductsCategory();
        body = response.data['data'];
        for (var product in body) products.add(Product.fromjson(product));
      } else if (event is Searchedproducts) {
        response = await DioHelper.postData(
            url: '$productsCategoryUrl?category_id=${event.categoryId}',
            body: {
              'category_id': event.categoryId,
              'name': event.searchedWord,
            });
        yield LoadedStateProductsCategory();
        body = response.data['data'];
        for (var product in body) products.add(Product.fromjson(product));
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) print('Internet Connecation');

      yield ErrorStateProductsCategory();
    }
  }
}
