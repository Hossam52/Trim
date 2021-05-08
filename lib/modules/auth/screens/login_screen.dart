import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/api_reponse.dart';
import 'package:trim/modules/auth/repositries/login_repositries.dart';
import 'package:trim/modules/auth/screens/forgot_password_screen.dart';
import 'package:trim/modules/auth/screens/registration_screen.dart';
import 'package:trim/modules/auth/widgets/social.dart';
import 'package:trim/utils/services/login_service.dart';
import 'package:trim/general_widgets/default_button.dart';
import '../../../general_widgets/transparent_appbar.dart';
import '../widgets/frame_card_auth.dart';
import '../../../general_widgets/trim_text_field.dart';
import '../../../core/auth/login/validate.dart';
import '../widgets/not_correct_input.dart';
import '../../../constants/app_constant.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_states.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

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
            validator: null,
          ),
          TrimTextField(
              controller: _passwordController,
              placeHolder: 'كلمة المرور',
              password: true,
              validator: null),
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
      onPressed: () =>
          AuthCubit.getInstance(context).navigateToRegister(context),
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
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (_, state) {
              if (state is NotActivatedAccountState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Not Activated account')));
              }
              if (state is ErrorAuthState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (_, state) {
              return CardLayout(
                children: [
                  if (state is InvalidFieldState)
                    ErrorWarning(text: state.errorMessage),
                  if (state is ErrorAuthState)
                    ErrorWarning(
                      text: state.errorMessage,
                    ),
                  if (state is NotActivatedAccountState)
                    ErrorWarning(
                      text: 'Activate Account Now',
                      widget: TextButton(
                        child: FittedBox(
                            child: Text('Activate',
                                style: TextStyle(color: Colors.black))),
                        onPressed: () {},
                      ),
                    ),
                  formFields,
                  DefaultButton(
                    widget: state is LoadingAuthState
                        ? Center(child: CircularProgressIndicator())
                        : null,
                    text: 'تسجيل الدخول',
                    onPressed: state is LoadingAuthState
                        ? null
                        : () {
                            AuthCubit.getInstance(context).login(
                                _userNameController.text,
                                _passwordController.text);
                          },
                  ),
                  forgotPassword,
                  createAccount,
                  Divider(),
                  Text('أو يمكنك التسجيل من خلال'),
                  SocialAuth(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
