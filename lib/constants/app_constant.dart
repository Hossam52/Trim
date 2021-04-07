import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';

class Splash {
  static const String splashBacground = "assets/images/splash-background.png";
  static Color splashColor = Color(0xff2B73A8).withAlpha(100);
}

final String logoImagePath = 'assets/images/logo.png';

final Color filledColor = Color(0xFFF6F6F6);
final double roundedRadius = 40.0;
final double backSize = 55;

final double defaultFontSize = 22;

//socail
final String facebookImagePath = 'assets/icons/facebook.png';
final String googleImagePath = 'assets/icons/google-plus.png';
double getFontSize(DeviceInfo deviceInfo) {
  return deviceInfo.type == deviceType.mobile
      ? 20
      : deviceInfo.type == deviceType.tablet
          ? 35
          : 45;
}

final kPadding = const EdgeInsets.only(bottom: 8, left: 8, right: 8);
