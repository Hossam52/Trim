import 'package:trim/modules/reservation/models/Reservation.dart';

abstract class ReservationStates {}

class IntialReservationState extends ReservationStates {}

class LoadingReservationState extends ReservationStates {}

class LoadedReservationStates extends ReservationStates {}

class ErrorReservationStates extends ReservationStates {
  final String errorMessage;

  ErrorReservationStates(this.errorMessage);
}
