import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/modules/home/screens/ReservationDetailsScreen.dart';

class ReservationItem extends StatelessWidget {
  final Reservation reservation;
  final double fontSize;
  final bool showMoreDetails;

  const ReservationItem(
      {Key key,
      @required this.reservation,
      @required this.fontSize,
      @required this.showMoreDetails})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Reservation no: ${reservation.requestNumber} ',
                  style: TextStyle(fontSize: fontSize),
                ),
              ),
              if (showMoreDetails) buildMoreDetails(context),
            ],
          ),
          Divider(
            height: 1,
            indent: 5,
            thickness: 1,
            color: Colors.grey,
          ),
          Table(
            border: TableBorder(
                verticalInside: BorderSide(width: 0.3, color: Colors.grey),
                horizontalInside: BorderSide(width: 0.3, color: Colors.grey)),
            children: [
              reservationRowItem(
                  // key: 'أسم الصالون',
                  key: 'Salon name',
                  value: reservation.salonName,
                  fontSize: fontSize),
              reservationRowItem(
                  // key: 'وقت الحجز',
                  key: 'Reservation time',
                  value:
                      '${reservation.reservationData.day} ${reservation.reservationData.data} الساعة ${reservation.reservationData.hour}',
                  fontSize: fontSize),
              reservationRowItem(
                  // key: 'العنوان',
                  key: 'Address',
                  value: reservation.address,
                  fontSize: fontSize),
              reservationRowItem(
                  key: 'Service type',
                  value: reservation.typeService,
                  fontSize: fontSize),
              reservationRowItem(
                  key: 'Status',
                  value: reservation.stateReservation,
                  fontSize: fontSize),
            ],
          ),
        ],
      ),
    );
  }

  Flexible buildMoreDetails(BuildContext context) {
    return Flexible(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ReservationDetailsScreen.routeName,
              arguments: reservation);
        },
        child: Text(
          'More details',
          style: TextStyle(fontSize: fontSize, color: Colors.green),
        ),
      ),
    );
  }

  TableRow reservationRowItem({String key, String value, double fontSize}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          key,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          value,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    ]);
  }
}
