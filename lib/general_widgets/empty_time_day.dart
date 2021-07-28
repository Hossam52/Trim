import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class EmptyTimeAtDay extends StatelessWidget {
  const EmptyTimeAtDay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) => Text(
          translatedWord('No Times for this salon at this date', context),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: defaultFontSize(deviceInfo) * 0.8)),
    );
  }
}
