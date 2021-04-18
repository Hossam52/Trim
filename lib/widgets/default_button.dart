import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import '../modules/auth/screens/registration_screen.dart';

const defaultColor = Color(0xff2B72A6);

class DefaultButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  const DefaultButton({
    Key key,
    this.formKey,
    @required this.text,
    @required this.onPressed,
    this.color = defaultColor,
    this.fontSize = 20,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(text),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: fontSize),
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
