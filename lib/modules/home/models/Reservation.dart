import 'package:flutter/foundation.dart';
import 'package:trim/modules/home/models/ReservationData.dart';

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

List<Reservation> reservations = [
  Reservation(
      salonName: 'الكسندرا',
      address: 'عمارات الامداد والتموين متفرع من 10 شارع النصر',
      reservationId: DateTime.now().toIso8601String(),
      stateReservation: 'ملغي بواسطة العميل',
      typeService: 'قص شعر',
      reservationData:
          ReservationData(data: '19-08-2020', day: 'الاربعاء', hour: '5:00'),
      requestNumber: '123'),
  Reservation(
      salonName: 'بيوتي سنتر',
      address: 'عمارات الامداد والتموين متفرع من 10 شارع النصر',
      reservationId: DateTime.now().toIso8601String(),
      stateReservation: 'تم عمله',
      typeService: 'عرض العروسة',
      reservationData:
          ReservationData(data: '19-04-2021', day: 'الثلاثاء', hour: '5:00'),
      requestNumber: '456'),
];
