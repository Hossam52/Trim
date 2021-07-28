import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/trim_text_field.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/cubits/auth_states.dart';
import 'package:trim/modules/auth/widgets/frame_card_auth.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class NewPasswordScreen extends StatefulWidget {
  final String token;

  const NewPasswordScreen({Key key, @required this.token}) : super(key: key);
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final res = await confirmBack(context);
        if (res != null && res) return Future.value(true);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(translatedWord('Change password', context))),
        body: Center(
          child: Container(
            height: ResponsiveFlutter.of(context).scale(460),
            child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (_, state) {
                if (state is ErrorChangingPasswordState) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
                if (state is SuccessChangedPasswordState)
                  Navigator.pop(context, true);
              },
              builder: (_, state) {
                return CardLayout(
                  children: [
                    buildFields(),
                    DefaultButton(
                      widget: state is ChangingPasswordState
                          ? TrimLoadingWidget()
                          : null,
                      text: translatedWord("Save", context),
                      onPressed: state is ChangingPasswordState
                          ? null
                          : () {
                              if (formKey.currentState.validate()) {
                                AuthCubit.getInstance(context).changePassword(
                                    passwordController.text, widget.token);
                              }
                            },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFields() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TrimTextField(
            controller: passwordController,
            placeHolder: translatedWord('Password', context),
            validator: (val) {
              if (val.isEmpty)
                return translatedWord('Password can not be empty', context);
              else if (val.length < 5)
                return translatedWord(
                    'Password can not be less than 6 characters', context);
              return null;
            },
          ),
          TrimTextField(
              controller: passwordConfirmationController,
              placeHolder: translatedWord('Password Confirmation', context),
              validator: (val) {
                if (val.isEmpty)
                  return translatedWord(
                      'Password confirmation can not be empty', context);
                if (passwordController.text != val)
                  return translatedWord('Two password not the same', context);
                return null;
              }),
        ],
      ),
    );
  }
}
