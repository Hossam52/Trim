import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import '../modules/auth/screens/registration_screen.dart';

const defaultColor = Color(0xff2B72A6);

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontSize;
  final Widget widget;
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.color = defaultColor,
    this.fontSize = 20,
    this.textColor = Colors.white,
    this.widget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: widget ??
              Text(text,
                  style: TextStyle(fontSize: fontSize, color: textColor)),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              primary: color,
              padding: const EdgeInsets.symmetric(vertical: 5)),
        ),
      ),
    );
  }
}
