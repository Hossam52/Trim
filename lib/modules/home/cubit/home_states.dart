abstract class HomeStates {}

class LoadingHomeState extends HomeStates {}

class SuccessHomeState extends HomeStates {}

class ErrorHomeState extends HomeStates {
  final String error;

  ErrorHomeState({this.error = ''});
}

class TrimStarState extends HomeStates {}

class MostSearchState extends HomeStates {}

class AllSalonsState extends HomeStates {}

class AllPersonsState extends HomeStates {}

class FavoriteState extends HomeStates {}

class ChangeSelectedBottomBarItemState extends HomeStates {}
