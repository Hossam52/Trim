import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';

class BuildBackButtonWidget extends StatelessWidget {
  final double localHeight;

  BuildBackButtonWidget({
    this.localHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        responsiveWidget: (context, deviceInfo) => Container(
              height: deviceInfo.type == deviceType.mobile
                  ? (localHeight / 11)
                  : (localHeight / 9),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: deviceInfo.type == deviceType.mobile ? 30 : 44,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ));
  }
}
