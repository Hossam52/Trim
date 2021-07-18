import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class UpdateArea {
  final String text;
  final Widget contentWidget;
  Tab tabWidget;
  UpdateArea({@required this.text, @required this.contentWidget}) {
    tabWidget = Tab(
      child: InfoWidget(
        responsiveWidget: (_, deviceInfo) => Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getFontSizeVersion2(deviceInfo) * 0.8),
        ),
      ),
    );
  }
}