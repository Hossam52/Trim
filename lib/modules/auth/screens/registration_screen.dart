import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/cubits/auth_states.dart';
import 'package:trim/modules/auth/repositries/register_repositry.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/auth/widgets/social.dart';
import 'package:trim/utils/services/register_service.dart';
import 'package:trim/utils/services/verification_code_service.dart';

import '../../../general_widgets/transparent_appbar.dart';
import '../../../constants/app_constant.dart';
import '../widgets/frame_card_auth.dart';
import '../../../general_widgets/trim_text_field.dart';
import '../../../core/auth/register/validate.dart';
import '../widgets/gender_selection.dart';
import '../../../general_widgets/default_button.dart';
import '../widgets/not_correct_input.dart';

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

  void onRegisteration(BuildContext context) async {
    AuthCubit.getInstance(context).register(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Widget _alreadyHasAccount = TextButton(
      onPressed: () => AuthCubit.getInstance(context).navigateToLogin(context),
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
            validator: null,
          ),
          TrimTextField(
            controller: _emailController,
            placeHolder: 'الايميل',
            validator: null,
            textInputType: TextInputType.emailAddress,
          ),
          TrimTextField(
            controller: _phoneController,
            placeHolder: 'رقم التليفون',
            validator: null,
            textInputType: TextInputType.phone,
          ),
          TrimTextField(
            controller: _passwordController,
            placeHolder: 'كلمة المرور',
            validator: null,
            password: true,
          ),
        ],
      ),
    );

    AuthCubit.getInstance(context).emit(LoadedAuthState());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TransparentAppBar(),
        body: Center(
          child: Container(
            height: ResponsiveFlutter.of(context).scale(620),
            child: BlocConsumer<AuthCubit, AuthStates>(
              buildWhen: (old, newState) {
                return newState is! ChangeGenderState;
              },
              listener: (_, state) {
                if (state is NotActivatedAccountState)
                  Navigator.of(context)
                      .pushNamed(VerificationCodeScreen.routeName);
              },
              builder: (_, state) {
                return CardLayout(
                  children: [
                    if (state is InvalidFieldState)
                      ErrorWarning(text: state.errorMessage),
                    if (state is ErrorAuthState)
                      ErrorWarning(text: state.errorMessage),
                    formFields,
                    BlocBuilder<AuthCubit, AuthStates>(
                      buildWhen: (oldState, newState) {
                        return newState is ChangeGenderState;
                      },
                      builder: (_, state) => GenderSelectionWidget(
                          changeGender:
                              AuthCubit.getInstance(context).changeGender,
                          selectedGender:
                              AuthCubit.getInstance(context).selectedGender),
                    ),
                    DefaultButton(
                      text: 'تسجيل حساب',
                      widget: state is LoadingAuthState
                          ? Center(child: CircularProgressIndicator())
                          : null,
                      onPressed: state is LoadingAuthState
                          ? null
                          : () => onRegisteration(context),
                    ),
                    _alreadyHasAccount,
                    Text('أو يمكنك التسجيل من خلال'),
                    SocialAuth(),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
