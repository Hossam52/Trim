import 'package:trim/modules/home/models/Salon.dart';

abstract class ReserveSalonStates {}

class IntialReserveState extends ReserveSalonStates {
  final Salon salon;
  IntialReserveState({this.salon});
}

class LoadingeserveState extends ReserveSalonStates {}

class LoadedReserveState extends ReserveSalonStates {}

class ErrorReserveState extends ReserveSalonStates {}
