abstract class ProductsCategoryEvents {
  final int categoryId;
  ProductsCategoryEvents(this.categoryId);
}

class FetchDataFromApi extends ProductsCategoryEvents {
  FetchDataFromApi({int categoryId}) : super(categoryId);
}

class Searchedproducts extends ProductsCategoryEvents {
  final String searchedWord;
  Searchedproducts({int categoryId, this.searchedWord}) : super(0);
}
