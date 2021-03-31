import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/auth/repositries/api_reponse.dart';
import 'package:trim/modules/auth/repositries/login_repositries.dart';
import 'package:trim/modules/auth/screens/forgot_password_screen.dart';
import 'package:trim/modules/auth/screens/registration_screen.dart';
import 'package:trim/utils/services/login_service.dart';
import 'package:trim/widgets/default_button.dart';
import '../../../widgets/transparent_appbar.dart';
import '../widgets/frame_card_auth.dart';
import '../../../widgets/trim_text_field.dart';
import '../../../core/auth/login/validate.dart';
import '../widgets/not_correct_input.dart';
import '../../../constants/app_constant.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  bool correctData = true;
  String errorMessage = "Email or password not correct";
  final LoginService service = LoginService();

  @override
  Widget build(BuildContext context) {
    final Widget formFields = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TrimTextField(
            controller: _userNameController,
            placeHolder: 'الايميل او الهاتف',
            validator: validateLogin,
          ),
          TrimTextField(
              controller: _passwordController,
              placeHolder: 'كلمة المرور',
              password: true,
              validator: validatePassword),
        ],
      ),
    );

    final Widget forgotPassword = RawMaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: const EdgeInsets.only(top: 10),
      constraints: BoxConstraints(),
      onPressed: () {
        Navigator.pushNamed(context, ForgotPassword.routeName);
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text('هل نسيت الرقم السري؟',
          style: TextStyle(color: Colors.grey, fontSize: 20)),
    );

    final Widget createAccount = RawMaterialButton(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      constraints: BoxConstraints(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.pushReplacementNamed(context, RegistrationScreen.routeName);
      },
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text('انشاء حساب',
          style: TextStyle(color: Colors.grey, fontSize: 18)),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TransparentAppBar(),
      body: Center(
        child: Container(
          height: ResponsiveFlutter.of(context).scale(460),
          child: CardLayout(
            children: [
              if (!correctData) ErrorWarning(text: errorMessage),
              formFields,
              DefaultButton(
                text: 'تسجيل الدخول',
                formKey: _formKey,
                onPressed: () {
                  setState(() {
                    correctData = true;
                  });
                  service
                      .makeLogin(
                          _userNameController.text, _passwordController.text)
                      .then(
                    (value) {
                      if (value.error) {
                        setState(() {
                          correctData = false;
                          errorMessage = value.errorMessage;
                        });
                      }
                    },
                  );
                },
              ),
              forgotPassword,
              createAccount,
              Divider(),
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
      ),
    );
  }
}
