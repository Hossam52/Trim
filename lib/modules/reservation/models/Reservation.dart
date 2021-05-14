import 'package:flutter/foundation.dart';
import 'package:trim/modules/reservation/models/ReservationData.dart';

class Reservation {
  final String salonName;
  final String requestNumber;
  final String reservationId;
  final String address;
  final String typeService;
  final String stateReservation;
  final ReservationData reservationData;
  double price;
  double discount;
  double totalPrice;
  Reservation(
      {@required this.salonName,
      @required this.address,
      @required this.reservationId,
      @required this.stateReservation,
      @required this.typeService,
      @required this.reservationData,
      @required this.requestNumber});
}
