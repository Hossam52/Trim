import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/CanceledReasons.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/modules/home/widgets/price_information.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/app_dialog.dart';
import 'package:trim/widgets/BuildAppBar.dart';
import 'package:trim/widgets/BuildCardWidget.dart';
import 'package:trim/widgets/reservation_item.dart';
import 'package:trim/widgets/default_button.dart';

class ReservationDetailsScreen extends StatelessWidget {
  static final String routeName = 'reservationDetailsScreen';

  @override
  Widget build(BuildContext context) {
    Reservation reservationData =
        ModalRoute.of(context).settings.arguments as Reservation;
    return Scaffold(
      body: SafeArea(child: InfoWidget(
        responsiveWidget: (context, deviceInfo) {
          double fontSize = getFontSizeVersion2(deviceInfo);
          return Column(
            children: [
              buildAppBar(
                  localHeight: deviceInfo.localHeight,
                  fontSize: fontSize,
                  screenName: 'Reservation details'),
              Expanded(
                child: SingleChildScrollView(
                  child: TrimCard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReservationItem(
                            reservation: reservationData,
                            fontSize: fontSize,
                            showMoreDetails: false),
                        Divider(
                          height: 2,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        PriceInformation(
                          showCopounsField: false,
                        ),
                        buildReservationActions(fontSize, context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }

  Row buildReservationActions(double fontSize, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
            text: 'Modify order',
            fontSize: fontSize,
            onPressed: () {},
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              text: 'Cancel order',
              color: Colors.black,
              fontSize: fontSize,
              onPressed: () async {
                await showReasonCancelled(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
