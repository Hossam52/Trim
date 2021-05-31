import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/auth/cubits/activate_cubit.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/cubits/auth_states.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';

import '../widgets/frame_card_auth.dart';
import '../../../general_widgets/trim_text_field.dart';
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

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void onRegisteration(BuildContext context) async {
    AuthCubit.getInstance(context).register(
      context: context,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: BlocConsumer<AuthCubit, AuthStates>(
            buildWhen: (old, newState) {
              return newState is! ChangeGenderState;
            },
            listener: (_, state) async {
              if (state is NotActivatedAccountState) {
                ActivateCubit.getInstance(context).accessToken =
                    AuthCubit.getInstance(context).registerModel.accessToken;
                await Navigator.of(context).pushNamed(
                    VerificationCodeScreen.routeName,
                    arguments: AuthCubit.getInstance(context)
                        .registerModel
                        .accessToken);
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              }
            },
            builder: (_, state) {
              return CardLayout(
                children: [
                  if (state is InvalidFieldState)
                    ErrorWarning(text: state.errorMessage),
                  if (state is ErrorRegisterState)
                    ErrorWarning(text: state.errorMessage),
                  buildFormFields(),
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
                    text: getWord('Register account', context),
                    widget: state is LoadingRegisterState
                        ? Center(child: CircularProgressIndicator())
                        : null,
                    onPressed: state is LoadingRegisterState
                        ? null
                        : () => onRegisteration(context),
                  ),
                  buildAlreadyHasAccount(),
                  // Text('أو يمكنك التسجيل من خلال'),
                  // SocialAuth(),
                ],
              );
            },
          ),
        ));
  }

  Widget buildFormFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TrimTextField(
            controller: _nameController,
            placeHolder: getWord('Name', context),
            validator: null,
          ),
          TrimTextField(
            controller: _emailController,
            placeHolder: getWord('Email', context),
            validator: null,
            textInputType: TextInputType.emailAddress,
          ),
          TrimTextField(
            controller: _phoneController,
            placeHolder: getWord('Phone', context),
            validator: null,
            textInputType: TextInputType.phone,
          ),
          TrimTextField(
            controller: _passwordController,
            placeHolder: getWord('Password', context),
            validator: null,
            password: true,
          ),
        ],
      ),
    );
  }

  Widget buildAlreadyHasAccount() {
    return TextButton(
      onPressed: () => AuthCubit.getInstance(context).navigateToLogin(context),
      child: Text(
        getWord('Already has account?', context),
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }
}
