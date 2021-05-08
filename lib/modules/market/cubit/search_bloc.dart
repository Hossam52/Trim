import 'package:bloc/bloc.dart';
import 'package:trim/modules/market/cubit/search_events.dart';
import 'package:trim/modules/market/cubit/search_states.dart';
import 'package:trim/modules/market/models/Product.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  SearchBloc() : super(null) ;
  List<Product> searchedProducts=[];
  @override
  Stream<SearchStates> mapEventToState(SearchEvents event) async* {
    try {
      searchedProducts = [];
      yield LoadingStateSearch();
      searchedProducts = event.products
          .where((element) => element.nameAr.startsWith(event.searchWord))
          .toList();
      print(searchedProducts[0].nameAr);
            print(searchedProducts[0].nameEn);

      yield LoadedStateSearch();
    } catch (e) {
      yield ErrorStateSearch();
    }
  }
}
