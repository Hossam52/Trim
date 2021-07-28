import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class ChoiceButton extends StatelessWidget {
  final VoidCallback pressed;
  final String icon;
  final String name;
  final bool directionRoundedRight;
  final bool active;
  ChoiceButton(
      {this.directionRoundedRight,
      this.icon,
      this.name,
      this.pressed,
      this.active = false});
  @override
  Widget build(BuildContext context) {
    Color activeColor = Colors.white;
    Color backgroundColor = Theme.of(context).primaryColor;
    Radius radius = Radius.circular(25);
    return Expanded(
      child: TextButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              active ? backgroundColor : Colors.white),
          foregroundColor:
              MaterialStateProperty.all(active ? activeColor : Colors.black87),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(width: 0.25, color: Colors.black),
              borderRadius: BorderRadius.only(
                topRight: directionRoundedRight ? radius : Radius.zero,
                bottomRight: directionRoundedRight ? radius : Radius.zero,
                topLeft: !directionRoundedRight ? radius : Radius.zero,
                bottomLeft: !directionRoundedRight ? radius : Radius.zero,
              ),
            ),
          ),
        ),
        onPressed: pressed,
        icon: Image.asset(
          icon,
          color: active ? activeColor : null,
          height: 25,
          width: 25,
        ),
        label: ResponsiveWidget(
            responsiveWidget: (_, deviceInfo) => Text(name,
                style: TextStyle(fontSize: defaultFontSize(deviceInfo) * 0.8))),
      ),
    );
  }
}
