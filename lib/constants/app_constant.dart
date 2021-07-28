import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';

import '../utils/ui/Core/Enums/DeviceType.dart';
import '../utils/ui/Core/Models/DeviceInfo.dart';

final double roundedRadius = 40.0;

double defaultFontSize(DeviceInfo deviceInfo) {
  if (deviceInfo.type == deviceType.mobile) {
    return deviceInfo.screenWidth *
        (deviceInfo.orientation == Orientation.portrait ? 0.0535 : 0.045);
  } else {
    return deviceInfo.screenWidth *
        (deviceInfo.orientation == Orientation.portrait ? 0.0435 : 0.035);
  }
}

final kPadding = const EdgeInsets.only(bottom: 8, left: 8, right: 8);
bool isCategoryScreen = true;
int connectionTimeOut = 15;
