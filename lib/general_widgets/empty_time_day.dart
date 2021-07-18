import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class EmptyTimeAtDay extends StatelessWidget {
  const EmptyTimeAtDay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Text(
          getWord('No Times for this salon at this date', context),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getFontSizeVersion2(deviceInfo) * 0.8)),
    );
  }
}
