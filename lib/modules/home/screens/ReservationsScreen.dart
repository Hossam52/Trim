import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Reservation.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/widgets/BuildAppBar.dart';
import 'package:trim/widgets/BuildCardWidget.dart';
import 'package:trim/widgets/reservation_item.dart';

import '../../../constants/app_constant.dart';

class ReservationsScreen extends StatelessWidget {
  static final String routeName = 'ReservationsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: InfoWidget(responsiveWidget: (context, deviceInfo) {
          double fontSize = getFontSizeVersion2(deviceInfo);

          return Column(
            children: [
              buildAppBar(
                  localHeight: deviceInfo.localHeight,
                  fontSize: fontSize,
                  screenName: 'My reservations'),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  itemCount: reservations.length,
                  itemBuilder: (context, index) => TrimCard(
                    child: ReservationItem(
                        reservation: reservations[index],
                        fontSize: fontSize,
                        showMoreDetails: true),
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
