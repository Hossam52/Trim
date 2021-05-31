import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/modules/reservation/screens/ReservationDetailsScreen.dart';

class ReservationItem extends StatelessWidget {
  final OrderModel reservation;
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
                  '${getWord('Reservation no', context)} : ${reservation.id} ',
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
              if (reservation.barberId != null)
                reservationRowItem(
                    key: getWord('Salon name', context),
                    values: [
                      reservation.barberName ?? getWord('Unknown', context)
                    ],
                    fontSize: fontSize),
              reservationRowItem(
                  key: getWord('Reservation time', context),
                  values: [
                    '${reservation.reservationTime ?? getWord('Unknown', context)}',
                    '${reservation.reservationDay ?? getWord('Unknown', context)}',
                  ],
                  fontSize: fontSize),
              if (!showMoreDetails)
                reservationRowItem(
                    key: getWord('Created at', context),
                    values: [
                      '${reservation.createdAt ?? getWord('Unknown', context)}',
                    ],
                    fontSize: fontSize),
              if (!showMoreDetails)
                reservationRowItem(
                    key: getWord('Payment method', context),
                    values: [
                      '${reservation.paymentMethod ?? getWord('Unknown', context)}',
                    ],
                    fontSize: fontSize),
              reservationRowItem(
                  key: getWord('Address', context),
                  values: [reservation.address ?? getWord('Unknown', context)],
                  fontSize: fontSize),
              reservationRowItem(
                  key: getWord('Service type', context),
                  values: [reservation.type],
                  fontSize: fontSize),
              if (!showMoreDetails)
                reservationRowItem(
                    key: '${reservation.type}',
                    values: getWhatToDisplayAccordingToType(reservation),
                    fontSize: fontSize),
              reservationRowItem(
                  key: getWord('Status', context),
                  values: [reservation.statusEn ?? getWord('Unknown', context)],
                  fontSize: fontSize),
              if (!showMoreDetails && reservation.statusId == "2")
                reservationRowItem(
                    key: getWord('Cancel reason', context),
                    values: [
                      reservation.cancelReason ?? getWord('Unknown', context)
                    ],
                    fontSize: fontSize),
            ],
          ),
        ],
      ),
    );
  }

  List<String> getWhatToDisplayAccordingToType(OrderModel reservation) {
    if (reservation.offers.isNotEmpty)
      return reservation.offers
          .map((element) => element.nameEn + '  X ${element.qty}')
          .toList();
    else if (reservation.services.isNotEmpty) {
      return reservation.services.map((element) => element.nameEn).toList();
    } else {
      if (reservation.products.isNotEmpty)
        return reservation.products
            .map((element) => element.nameEn + '  X ${element.productQuantity}')
            .toList();
    }
    return [];
  }

  Flexible buildMoreDetails(BuildContext context) {
    return Flexible(
      child: TextButton(
        onPressed: () {
          ReservationCubit.getInstance(context)
              .setSelectedReservationItem(reservation);
          Navigator.pushNamed(context, ReservationDetailsScreen.routeName,
              arguments: reservation);
        },
        child: Text(
          getWord('More details', context),
          style: TextStyle(fontSize: fontSize, color: Colors.green),
        ),
      ),
    );
  }

  TableRow reservationRowItem(
      {String key, List<String> values, double fontSize}) {
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
        child: Column(
          children: values
              .map(
                (value) => Text(
                  value,
                  style: TextStyle(fontSize: fontSize),
                ),
              )
              .toList(),
        ),
      ),
    ]);
  }
}
