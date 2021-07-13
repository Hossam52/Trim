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
                  style: TextStyle(fontSize: fontSize * 0.8),
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
                ),
              reservationRowItem(
                  key: getWord('Reservation time', context),
                  values: [
                    '${reservation.reservationTime ?? getWord('Unknown', context)}',
                    '${reservation.reservationDay ?? getWord('Unknown', context)}',
                  ]),
              if (!showMoreDetails)
                reservationRowItem(
                    key: getWord('Created at', context),
                    values: [
                      '${reservation.createdAt ?? getWord('Unknown', context)}',
                    ]),
              if (!showMoreDetails)
                reservationRowItem(
                    key: getWord('Payment method', context),
                    values: [
                      '${reservation.paymentMethod ?? getWord('Unknown', context)}',
                    ]),
              reservationRowItem(
                  key: getWord('Address', context),
                  values: [reservation.address ?? getWord('Unknown', context)]),
              reservationRowItem(
                  key: getWord('Service type', context),
                  values: [reservation.type]),
              if (!showMoreDetails)
                reservationRowItem(
                    key: '${reservation.type}',
                    values: getWhatToDisplayAccordingToType(reservation)),
              reservationRowItem(key: getWord('Status', context), values: [
                reservation.statusEn ?? getWord('Unknown', context)
              ]),
              if (!showMoreDetails && reservation.statusId == "2")
                reservationRowItem(
                    key: getWord('Cancel reason', context),
                    values: [
                      reservation.cancelReason ?? getWord('Unknown', context)
                    ]),
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
          style: TextStyle(fontSize: fontSize * 0.8, color: Colors.green),
        ),
      ),
    );
  }

  TableRow reservationRowItem({String key, List<String> values}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          key,
          style:
              TextStyle(fontSize: fontSize * 0.85, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: values
              .map(
                (value) => Text(
                  value,
                  style: TextStyle(fontSize: fontSize * 0.75),
                ),
              )
              .toList(),
        ),
      ),
    ]);
  }
}
