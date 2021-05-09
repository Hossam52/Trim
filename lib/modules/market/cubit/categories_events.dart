abstract class CategoriesEvents {
}

class CategoriesFetchDataFromApi extends CategoriesEvents {

}

class SearchedCategories extends CategoriesEvents {
  final String searchedWord;
  SearchedCategories({this.searchedWord});
}
