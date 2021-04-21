import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart' as constants;
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildBackButtonWidget.dart';
import 'package:trim/widgets/BuildTrimStarItem.dart' as star;

class TrimStarReservationScreen extends StatelessWidget {
  static final String routeName = 'trimStarReservationScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Padding(
          padding: constants.kPadding,
          child: InfoWidget(
            responsiveWidget: (context, deviceInfo) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildBackButtonWidget(
                    localHeight: deviceInfo.localHeight,
                  ),
                  Container(
                    height: deviceInfo.orientation == Orientation.portrait
                        ? deviceInfo.localHeight / 2
                        : deviceInfo.localHeight / 1.2,
                    margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: deviceInfo.orientation == Orientation.portrait
                            ? deviceInfo.localHeight / 6
                            : 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300],
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: deviceInfo.orientation == Orientation.portrait
                              ? deviceInfo.localHeight / 4
                              : deviceInfo.localHeight / 2.4,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: star.buildTrimStarItem(starItemScreen: true),
                        ),
                        if (deviceInfo.orientation == Orientation.portrait)
                          Divider(
                            height: 2,
                          ),
                        BuildButtonStarItem(
                          color: Colors.cyan,
                          pressed: () {},
                          label: 'أحجز الأن',
                          deviceInfo: deviceInfo,
                        ),
                        BuildButtonStarItem(
                          color: Colors.black,
                          pressed: () {},
                          label: 'أحجز بموعد',
                          deviceInfo: deviceInfo,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildButtonStarItem extends StatelessWidget {
  final String label;
  final Function pressed;
  final Color color;
  final DeviceInfo deviceInfo;
  const BuildButtonStarItem(
      {Key key, this.label, this.pressed, this.color, this.deviceInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: deviceInfo.orientation == Orientation.landscape
          ? EdgeInsets.symmetric(horizontal: 20, vertical: 5)
          : const EdgeInsets.symmetric(
              horizontal: 20,
            ),
      child: MaterialButton(
        padding: deviceInfo.orientation == Orientation.landscape
            ? EdgeInsets.symmetric(vertical: 10)
            : EdgeInsets.symmetric(vertical: 2),
        onPressed: pressed,
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: constants.getFontSizeVersion2(deviceInfo)),
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
