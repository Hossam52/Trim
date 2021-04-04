import 'package:flutter/cupertino.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';

deviceType getDeviceType(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = mediaQueryData.size.width;
  if (orientation == Orientation.landscape) width = mediaQueryData.size.height;
  if (width >= 950)
    return deviceType.desktop;
  else if (width >= 600)
    return deviceType.tablet;
  else
    return deviceType.mobile;
}
