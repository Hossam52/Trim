import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class SettingItem extends StatelessWidget {
  final String label;
  final Function function;
  final String imagename;
  SettingItem({this.function, this.imagename, this.label});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            onTap: function,
            leading: Image.asset(
              'assets/icons/$imagename.png',
              height: getFontSizeVersion2(deviceInfo),
              width: getFontSizeVersion2(deviceInfo),
            ),
            title: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSizeVersion2(deviceInfo) * 0.85),
            ),
          ),
        );
      },
    );
  }
}
