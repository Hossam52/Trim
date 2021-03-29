import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import '../modules/auth/screens/registration_screen.dart';

class DefaultButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Gender gender;
  final String text;

  const DefaultButton(
      {Key key, @required this.formKey, this.gender, @required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(text),
          onPressed: () {
            if (formKey.currentState.validate()) {}
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
