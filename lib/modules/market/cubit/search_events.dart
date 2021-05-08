import 'package:trim/modules/market/models/Product.dart';

abstract class SearchEvents {
  final String searchWord;
  final List<Product> products;
  SearchEvents(this.searchWord, this.products);
}

class SearchEvent extends SearchEvents {
  SearchEvent({String searchWord, List<Product> products})
      : super(searchWord, products);
}
