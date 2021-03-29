import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import '../screens/registration_screen.dart';

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Gender gender;

  const RegisterButton({Key key, @required this.formKey, @required this.gender})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text('تسجيل حساب'),
          onPressed: () {
            if (formKey.currentState.validate()) {
              if (gender == null) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('يجب اختيار النوع')));
                return;
              }
              formKey.currentState.save();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('تم التسجيل بنجاح')));
            }
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
