import 'package:flutter/cupertino.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';

class DeviceInfo {
  final Orientation orientation;
  final deviceType type;
  final double screenHeight;
  final double screenWidth;
  final double localWidth;
  final double localHeight;

  DeviceInfo(
      {this.orientation,
      this.type,
      this.screenHeight,
      this.screenWidth,
      this.localWidth,
      this.localHeight});
}
