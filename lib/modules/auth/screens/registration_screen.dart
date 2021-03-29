import 'package:flutter/material.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';

import '../../../widgets/transparent_appbar.dart';
import '../../../constants/app_constant.dart';
import '../widgets/frame_card_auth.dart';
import '../../../widgets/trim_text_field.dart';
import '../../../core/auth/register/validate.dart';
import '../widgets/gender_selection.dart';
import '../../../widgets/default_button.dart';
import '../widgets/not_correct_input.dart';

enum Gender {
  Male,
  Female,
}

class RegistrationScreen extends StatefulWidget {
  static final String routeName = '/registration';
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  Gender selectedGender;
  bool correctData = true;
  void changeGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget _alreadyHasAccount = TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      },
      child: Text(
        'هل لديك حساب بالفعل؟',
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );

    final Widget formFields = Form(
      key: _formKey,
      child: Column(
        children: [
          TrimTextField(
            controller: _nameController,
            placeHolder: 'الاسم',
            validator: validateName,
          ),
          TrimTextField(
            controller: _emailController,
            placeHolder: 'الايميل',
            validator: validateEmail,
            textInputType: TextInputType.emailAddress,
          ),
          TrimTextField(
            controller: _phoneController,
            placeHolder: 'رقم التليفون',
            validator: validatePhone,
            textInputType: TextInputType.phone,
          ),
          TrimTextField(
            controller: _passwordController,
            placeHolder: 'كلمة المرور',
            validator: validatePassword,
            password: true,
          ),
        ],
      ),
    );
    return Scaffold(
        appBar: TransparentAppBar(),
        body: CardLayout(
          children: [
            if (!correctData) ErrorWarning(text: 'يجب ادخال الداتا'),
            formFields,
            GenderSelectionWidget(
              changeGender: changeGender,
              selectedGender: selectedGender,
            ),
            DefaultButton(
              text: 'تسجيل حساب',
              gender: selectedGender,
              formKey: _formKey,
            ),
            _alreadyHasAccount,
            Text('أو يمكنك التسجيل من خلال'),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Image.asset(facebookImagePath), onPressed: () {}),
                IconButton(
                    icon: Image.asset(googleImagePath), onPressed: () {}),
              ],
            ),
          ],
        ));
  }
}
