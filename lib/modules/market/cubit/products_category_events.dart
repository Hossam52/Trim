abstract class ProductsCategoryEvents {
  final int categoryId;
  ProductsCategoryEvents(this.categoryId);
}

class FetchDataFromApi extends ProductsCategoryEvents {
  FetchDataFromApi({int categoryId}) : super(categoryId);
}
