abstract class PersonStates {}

class EmptyPersonListState extends PersonStates {}

class IntialPersonsState extends PersonStates {}

class LoadingPersonsState extends PersonStates {}

class LoadedPersonsState extends PersonStates {}

class ErrorPersonsState extends PersonStates {
  final String error;

  ErrorPersonsState({this.error = ""});
}

class LoadingMorePersonState extends PersonStates {}

class LoadedMorePersonState extends PersonStates {}

class NoMorePersonState extends PersonStates {}

class ErrorMorePersonState extends PersonStates {
  final String error;

  ErrorMorePersonState({this.error = ""});
}
