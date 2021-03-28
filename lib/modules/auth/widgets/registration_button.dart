import 'package:flutter/material.dart';
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
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
