import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/widgets/BuildAppBar.dart';
import 'package:trim/widgets/BuildCardWidget.dart';
import 'package:trim/widgets/BuildItemReservation.dart';

class ReservationsScreen extends StatelessWidget {
  static final String routeName = 'ReservationsScreen';
  double fontSize = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: InfoWidget(responsiveWidget: (context, deviceInfo) {
          fontSize = getFontSize(deviceInfo);
          return Column(
            children: [
              buildAppBar(
                  localHeight: deviceInfo.localHeight,
                  fontSize: fontSize,
                  screenName: 'حجوزاتي'),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemCount: reservations.length,
                  itemBuilder: (context, index) => buildCardWidget(
                    child: buildItemReservation(
                        reservations[index], fontSize, true, context),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
