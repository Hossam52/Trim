import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/Methods/getDeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo)
      responsiveWidget;
  InfoWidget({this.responsiveWidget});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var mediaQueryData = MediaQuery.of(context);
        DeviceInfo deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          screenHeight: mediaQueryData.size.height,
          screenWidth: mediaQueryData.size.width,
          localHeight: constraints.maxHeight,
          localWidth: constraints.maxWidth,
          type: getDeviceType(mediaQueryData),
        );
        return responsiveWidget(
          context,
          deviceInfo,
        );
      },
    );
  }
}
