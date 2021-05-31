import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/auth/cubits/activate_cubit.dart';
import 'package:trim/modules/auth/cubits/activate_states.dart';
import 'package:trim/modules/auth/models/token_model.dart';
import 'package:trim/modules/auth/screens/new_password_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/auth/widgets/frame_card_auth.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_text_field.dart';
import '../cubits/auth_cubit.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = '/forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool correctData = true;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: BlocConsumer<ActivateCubit, ActivateStates>(
        listener: (_, state) async {
          if (state is ErrorRequestActivationCodeState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is SuccessRequestActivationCodeState) {
            final res = await Navigator.of(context)
                .pushNamed(VerificationCodeScreen.routeName);
            if (res != null && res == true) {
              TokenModel model =
                  ActivateCubit.getInstance(context).activationTokenModel;
              final changePasswordSuccess = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewPasswordScreen(
                    token: model.token,
                  ),
                ),
              );

              if (changePasswordSuccess != null && changePasswordSuccess) {
                showSnackBar(
                    context, getWord('Changing password Success', context));
              } else {
                showSnackBar(
                    context, getWord('Changing password failed', context));
              }
            } else {
              showSnackBar(
                  context, getWord('Changing password failed', context));
            }
            Navigator.pop(context);
          }
        },
        builder: (_, state) {
          final requestingActivateCode =
              state is RequestingNewActivatationCodeState;
          return CardLayout(
            children: [
              Form(
                key: formKey,
                child: TrimTextField(
                    controller: _emailController,
                    validator: (val) {
                      return AuthCubit.getInstance(context)
                          .validateLogin(val, context);
                    },
                    placeHolder: getWord('Email', context)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                  text: getWord('Search', context),
                  onPressed: requestingActivateCode
                      ? null
                      : () async {
                          if (formKey.currentState.validate()) {
                            await ActivateCubit.getInstance(context)
                                .requestActivationCode(_emailController.text);
                          }
                        },
                  widget: requestingActivateCode
                      ? Center(child: CircularProgressIndicator())
                      : null,
                ),
              )
            ],
          );
        },
      )),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$message'),
        ),
      );
  }
}
