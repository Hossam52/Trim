abstract class CitiesStates {}

class IntialReserveState extends CitiesStates {}

class LoadingCitiesState extends CitiesStates {}

class LoadedCitiesState extends CitiesStates {}

class EmptyCitiesState extends CitiesStates {}

class ErrorCitiesState extends CitiesStates {
  final String errorMessage;

  ErrorCitiesState(this.errorMessage);
}

class ChangeSelectedCity extends CitiesStates {}
