import 'package:trim/modules/reservation/models/Reservation.dart';

abstract class ReservationStates {}

class IntialReservationState extends ReservationStates {}

class LoadingReservationState extends ReservationStates {}

class LoadedReservationStates extends ReservationStates {}

class ErrorReservationState extends ReservationStates {
  final String errorMessage;

  ErrorReservationState(this.errorMessage);
}

class LoadingCancelReservationState extends ReservationStates {}

class LoadedCancedReservationState extends ReservationStates {}
