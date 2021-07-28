import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class UpdateArea {
  final String text;
  final Widget contentWidget;
  Tab tabWidget;
  UpdateArea({@required this.text, @required this.contentWidget}) {
    tabWidget = Tab(
      child: ResponsiveWidget(
        responsiveWidget: (_, deviceInfo) => Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: defaultFontSize(deviceInfo) * 0.8),
        ),
      ),
    );
  }
}
