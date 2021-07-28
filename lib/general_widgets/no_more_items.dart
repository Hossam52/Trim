import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class NoMoreItems extends StatelessWidget {
  final String label;
  final DeviceInfo deviceInfo;

  const NoMoreItems({Key key, @required this.deviceInfo, @required this.label})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(label,
            style: TextStyle(fontSize: defaultFontSize(deviceInfo))),
      ),
    );
  }
}
