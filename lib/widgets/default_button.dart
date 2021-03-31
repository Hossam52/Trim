import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import '../modules/auth/screens/registration_screen.dart';

class DefaultButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String text;
  final VoidCallback onPressed;
  const DefaultButton({
    Key key,
    this.formKey,
    @required this.text,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(text),
          onPressed: () {
            if (formKey != null && formKey.currentState.validate()) {
              onPressed();
            } else
              onPressed();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(roundedRadius),
              ),
              primary: Color(0xff2B72A6),
              padding: const EdgeInsets.symmetric(vertical: 5)),
        ),
      ),
    );
  }
}
