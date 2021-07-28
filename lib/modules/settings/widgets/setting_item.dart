import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class SettingItem extends StatelessWidget {
  final String label;
  final Function function;
  final String iconPath;
  SettingItem({this.function, this.iconPath, this.label});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (context, deviceInfo) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            onTap: function,
            leading: Image.asset(
              iconPath,
              height: defaultFontSize(deviceInfo),
              width: defaultFontSize(deviceInfo),
            ),
            title: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: defaultFontSize(deviceInfo) * 0.85),
            ),
          ),
        );
      },
    );
  }
}
