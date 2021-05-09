//for Custom app dialogs

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/general_widgets/cancel_reasons.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

import 'Core/BuilderWidget/InfoWidget.dart';

void personDetailsDialog(
    DeviceInfo deviceInfo, BuildContext context, Salon salon) async {
  Widget elevatedButton(String text, VoidCallback onPressed,
      [Color color = Colors.blue]) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius))),
            ),
            onPressed: onPressed,
            child: FittedBox(child: Text(text))));
  }

  await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: TrimCachedImage(
                          src: salon.image,
                          width: 0,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              salon.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getFontSizeVersion2(deviceInfo)),
                            ),
                            BuildStars(
                                stars: salon.rate,
                                width: MediaQuery.of(context).size.width / 2),
                            Text('${salon.commentsCount} Openion')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                elevatedButton('Reserve now', () {
                  SalonsCubit.getInstance(context)
                      .getSalonDetails(id: salon.id);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ReserveScreen.routeName,
                      arguments: SalonDetailModel(
                          showDateWidget: false,
                          showAvailableTimes: true,
                          showServiceWidget: true,
                          showOffersWidget: false));
                }),
                elevatedButton('Reserve appointment', () {
                  SalonsCubit.getInstance(context)
                      .getSalonDetails(id: salon.id);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ReserveScreen.routeName,
                      arguments: SalonDetailModel(
                          showDateWidget: true,
                          showAvailableTimes: true,
                          showServiceWidget: true,
                          showOffersWidget: true));
                }, Colors.black),
              ],
            ),
          ),
        );
      });
}

Future<bool> exitConfirmationDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Alert'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes', style: TextStyle(color: Colors.red))),
            ],
            content: Text('Are you sure to exit?'),
            contentTextStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                color: Colors.black),
            contentPadding: const EdgeInsets.all(15),
          ));
}

Future<void> showReasonCancelled(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return InfoWidget(
          responsiveWidget: (context, deviceInfo) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: deviceInfo.orientation == Orientation.portrait
                              ? deviceInfo.type == deviceType.mobile
                                  ? 45
                                  : 80
                              : deviceInfo.type == deviceType.mobile
                                  ? 80
                                  : 95),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: CancelReasons(deviceInfo),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    heightFactor: 1,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width /
                          (deviceInfo.orientation == Orientation.portrait
                              ? 5
                              : 6),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
