import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/modules/home/screens/ReservationDetailsScreen.dart';

import 'BuildItemRowTable.dart';

Widget buildItemReservation(Reservation reservation, double fontSize,
    bool reservationScreen, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reservation no: ${reservation.requestNumber} ',
              style: TextStyle(fontSize: fontSize),
            ),
            if (reservationScreen)
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, ReservationDetailsScreen.routeName,
                      arguments: reservation);
                },
                child: Text(
                  'More details',
                  style: TextStyle(fontSize: fontSize, color: Colors.green),
                ),
              ),
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
          columnWidths: {
            0: FractionColumnWidth(0.3),
            1: FractionColumnWidth(0.7),
          },
          children: [
            TableRow(
              children: buildItemRowTable(
                  // key: 'أسم الصالون',
                  key: 'Salon name',
                  value: reservation.salonName,
                  fontSize: fontSize),
            ),
            TableRow(
              children: buildItemRowTable(
                  // key: 'وقت الحجز',
                  key: 'Reservation time',
                  value:
                      '${reservation.reservationData.day} ${reservation.reservationData.data} الساعة ${reservation.reservationData.hour}',
                  fontSize: fontSize),
            ),
            TableRow(
                children: buildItemRowTable(
                    // key: 'العنوان',
                    key: 'Address',
                    value: reservation.address,
                    fontSize: fontSize)),
            TableRow(
                children: buildItemRowTable(
                    key: 'Service type',
                    value: reservation.typeService,
                    fontSize: fontSize)),
            TableRow(
                children: buildItemRowTable(
                    key: 'Status',
                    value: reservation.stateReservation,
                    fontSize: fontSize)),
          ],
        ),
      ],
    ),
  );
}
