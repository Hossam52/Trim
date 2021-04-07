import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/screens/TrimStarReservationScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildBackButtonWidget.dart';
import 'package:trim/widgets/BuildTrimStarItem.dart';
=======
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/app_dialog.dart';
>>>>>>> 0258ccc813714d4e9c5d2a8f79ad87682c941018

class TrimStarsScreen extends StatelessWidget {
  static final String routeName = 'TrimStarsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPadding,
          child: InfoWidget(
            responsiveWidget: (context, deviceInfo) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildBackButtonWidget(
                    localHeight: deviceInfo.localHeight,
                  ),
                  Expanded(
                    child: ListView.builder(
<<<<<<< HEAD
                      itemCount: 3,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, TrimStarReservationScreen.routeName);
                        },
                        child: Container(
                            width: deviceInfo.localWidth,
                            height:
                                deviceInfo.orientation == Orientation.portrait
                                    ? deviceInfo.localHeight / 4.5
                                    : deviceInfo.localHeight / 2.5,
                            child: buildTrimStarItem(starItemScreen: false)),
                      ),
                    ),
                  ),
=======
                        itemCount: barbers.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                print('Enter Here');
                                personDetailsDialog(context, barbers[index]);
                              },
                              child: Container(
                                  width: deviceInfo.localWidth,
                                  height: deviceInfo.orientation ==
                                          Orientation.portrait
                                      ? deviceInfo.localHeight / 4.5
                                      : deviceInfo.localHeight / 2.5,
                                  child: buildTrimStarItem(barbers[index])),
                            )),
                  )
>>>>>>> 0258ccc813714d4e9c5d2a8f79ad87682c941018
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

double getFontSize(DeviceInfo deviceInfo) {
  return deviceInfo.type == deviceType.mobile
      ? 20
      : deviceInfo.type == deviceType.tablet
          ? 35
          : 45;
}

Widget buildTrimStarItem(Barber barber) {
  return InfoWidget(
    responsiveWidget: (context, deviceInfo) {
      print(deviceInfo.type);
      return Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  barber.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      barber.name,
                      style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: getFontSize(deviceInfo)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      height: deviceInfo.orientation == Orientation.portrait
                          ? deviceInfo.localHeight / 6
                          : deviceInfo.localHeight / 5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          padding: EdgeInsets.zero,
                          itemCount: 5,
                          itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(2),
                                child: index > barber.stars
                                    ? Icon(Icons.star_border_sharp)
                                    : Image.asset(
                                        'assets/icons/star.png',
                                        fit: BoxFit.fill,
                                      ),
                              )),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Text(
                            barber.discription ?? 'No discription available',
                            style: TextStyle(fontSize: getFontSize(deviceInfo)),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
>>>>>>> 0258ccc813714d4e9c5d2a8f79ad87682c941018
