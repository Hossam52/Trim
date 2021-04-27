import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class BuildRawMaterialButton extends StatelessWidget {
  final IconData icon;
  final Function pressed;
  final DeviceInfo deviceInfo;
  BuildRawMaterialButton({this.icon, this.pressed, this.deviceInfo});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: pressed,
        child: Icon(
          icon,
          size: deviceInfo.orientation == Orientation.portrait
              ? deviceInfo.type == deviceType.mobile
                  ? 30
                  : 40
              : 45,
        ),
        shape: const CircleBorder(
            side: BorderSide(
          width: 1,
          color: Colors.black,
        )),
      ),
    );
  }
}
