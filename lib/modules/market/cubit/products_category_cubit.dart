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
      emit(LoadingState());
      final response = await DioHelper.postData(
          url: '$productsCategoryUrl?category_id=$categoryId', body: {});
      emit(LoadedState());
      print(response.data);
    } catch (e) {
      emit(ErrorStateProductsCategory());
      print(e.toString());
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
    if (event is FetchDataFromApi) {
      try {
        products = [];
        yield LoadingState();
        final response = await DioHelper.postData(
            url: '$productsCategoryUrl?category_id=${event.categoryId}',
            body: {});
        yield LoadedState();
        print(response.data);
        var body = response.data['data'];
        for (var product in body) products.add(Product.fromjson(product));
      } catch (e) {
        yield ErrorStateProductsCategory();
        print('\n');
        print(e.toString());
      }
    } else if (event is Searchedproducts) {
      if (event.searchedWord != "") {
        yield InitialState();
        try {
          yield LoadingState();

          searchedProducts = products.where(
              (element) => element.nameAr.startsWith(event.searchedWord));

          yield LoadedState();
        } catch (e) {}
      }
    }
  }

  void updateProduct(int productId) {
    // products.wh
  }
}
