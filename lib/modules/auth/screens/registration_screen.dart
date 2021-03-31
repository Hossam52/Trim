import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/auth/repositries/register_repositry.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/utils/services/register_service.dart';
import 'package:trim/utils/services/verification_code_service.dart';

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

  RegisterService _service = RegisterService();
  String errorMessage = 'يجب ادخال البيانات';
  Gender selectedGender;
  bool correctData = true;
  void changeGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void onRegisteration() async {
    if (!correctData)
      setState(() {
        correctData = true;
      });
    RegisterReposistry user = RegisterReposistry(
      name: _nameController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      confirmPassword: _passwordController.text,
      gender: selectedGender == Gender.Male ? 'male' : 'female',
      email: _emailController.text,
    );

    _service.signUp(user).then((response) {
      if (response.error) {
        setState(() {
          correctData = false;
          errorMessage = response.errorMessage;
        });
        print(response.errorMessage);
      } else {
        print('Succissiful');
        String token = response.data;
        ActivationProcessServices()
            .getVerificationCode(
                _emailController.text, _passwordController.text, token)
            .then((value) {
          print(value.data);

          Navigator.pushReplacementNamed(
              context, VerificationCodeScreen.routeName,
              arguments: {
                "verificationCode": value.data,
                "token": token,
              });
        });
      }
    });
    return;
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
        resizeToAvoidBottomInset: false,
        appBar: TransparentAppBar(),
        body: Center(
          child: Container(
            height: ResponsiveFlutter.of(context).scale(620),
            child: CardLayout(
              children: [
                if (!correctData) ErrorWarning(text: errorMessage),
                formFields,
                GenderSelectionWidget(
                  changeGender: changeGender,
                  selectedGender: selectedGender,
                ),
                DefaultButton(
                  text: 'تسجيل حساب',
                  formKey: _formKey,
                  onPressed: onRegisteration,
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
            ),
          ),
        ));
  }
}
