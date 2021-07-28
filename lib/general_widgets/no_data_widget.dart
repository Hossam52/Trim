import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(noItemsImage,
                width: double.infinity, height: deviceInfo.screenHeight * 0.4),
            Text(
              'No Items found',
              style: TextStyle(fontSize: defaultFontSize(deviceInfo)),
            ),
          ],
        );
      },
    );
  }
}
