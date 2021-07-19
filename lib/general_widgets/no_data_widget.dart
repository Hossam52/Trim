import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_items.png',
                width: double.infinity, height: deviceInfo.screenHeight * 0.4),
            Text(
              'No Items found',
              style: TextStyle(fontSize: getFontSizeVersion2(deviceInfo)),
            ),
          ],
        );
      },
    );
  }
}
