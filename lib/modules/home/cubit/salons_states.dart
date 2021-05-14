abstract class SalonStates {}

class InitialSalonState extends SalonStates {}

class LoadingSalonState extends SalonStates {}

class LoadedSalonState extends SalonStates {}

class ErrorSalonState extends SalonStates {
  final String error;

  ErrorSalonState({this.error = ""});
}

class NoMoreSalonState extends SalonStates {}

class LoadingMoreSalonState extends SalonStates {}

class LoadedMoreSalonState extends SalonStates {}

class LoadingSalonDetailState extends SalonStates {}

class ErrorSalonDetailState extends SalonStates {}

class ChangeSelecteTimeState extends SalonStates {}

class ChangeSelectedDateState extends SalonStates {}

class LoadingAvilableDatesState extends SalonStates {}

class EmptyAvialbleDatesState extends SalonStates {}

class ErrorAvilableDatesState extends SalonStates {}

class ChangeFavoriteState extends SalonStates {}

class ToggleSelectedServiceState extends SalonStates {}

class LoadingMakeOrderState extends SalonStates {}

class LoadedMakeOrderState extends SalonStates {}
