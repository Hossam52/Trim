import 'package:flutter/material.dart';
import 'package:trim/core/auth/login/validate.dart';
import 'package:trim/core/auth/register/validate.dart';
import 'package:trim/modules/auth/widgets/frame_card_auth.dart';
import 'package:trim/modules/auth/widgets/not_correct_input.dart';
import 'package:trim/widgets/default_button.dart';
import 'package:trim/widgets/transparent_appbar.dart';
import 'package:trim/widgets/trim_text_field.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  String errorMessage = "Can't find this user";

  bool correctData = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: TransparentAppBar(),
          body: CardLayout(
            children: [
              if (!correctData) ErrorWarning(text: errorMessage),
              TrimTextField(
                  controller: _emailController,
                  validator: validateLogin,
                  placeHolder: 'الايميل الالكتروني'),
              DefaultButton(
                text: 'البحث',
                onPressed: () {
                  ///search for that user and getverificationCode and activate it then change password
                },
              )
            ],
          )),
    );
  }
}
