import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/modules/home/screens/ReservationDetailsScreen.dart';

import 'BuildItemRowTable.dart';

Widget buildItemReservation(Reservation reservation, double fontSize,
    bool reservationScreen, BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${reservation.requestNumber} :رقم الطلب',
            style: TextStyle(fontSize: fontSize),
          ),
          if (reservationScreen)
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ReservationDetailsScreen.routeName,
                    arguments: reservation);
              },
              child: Text(
                'تفاصيل اكتر',
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
                key: 'أسم الصالون',
                value: reservation.salonName,
                fontSize: fontSize),
          ),
          TableRow(
            children: buildItemRowTable(
                key: 'وقت الحجز',
                value:
                    '${reservation.reservationData.day} ${reservation.reservationData.data} الساعة ${reservation.reservationData.hour}',
                fontSize: fontSize),
          ),
          TableRow(
              children: buildItemRowTable(
                  key: 'العنوان',
                  value: reservation.address,
                  fontSize: fontSize)),
          TableRow(
              children: buildItemRowTable(
                  key: 'نوع الخدمة',
                  value: reservation.typeService,
                  fontSize: fontSize)),
          TableRow(
              children: buildItemRowTable(
                  key: 'الحالة',
                  value: reservation.stateReservation,
                  fontSize: fontSize)),
        ],
      ),
    ],
  );
}
