import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/modules/auth/cubits/activate_cubit.dart';
import 'package:trim/modules/auth/cubits/activate_states.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/auth/widgets/frame_card_auth.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class ActivateAccountScreen extends StatelessWidget {
  final String emailOrPhone;

  const ActivateAccountScreen({Key key, @required this.emailOrPhone})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(translatedWord('Activate account', context))),
      body: ResponsiveWidget(
        responsiveWidget: (_, deviceInfo) => Center(
          child: BlocConsumer<ActivateCubit, ActivateStates>(
            listener: (_, state) async {
              if (state is SuccessRequestActivationCodeState)
                await Navigator.pushReplacementNamed(
                    context, VerificationCodeScreen.routeName);
              if (state is ErrorRequestActivationCodeState)
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
            },
            builder: (_, state) {
              final bool requestingCode =
                  state is RequestingNewActivatationCodeState;
              return CardLayout(children: [
                Text(
                    translatedWord(
                        'You need to activate account to continue using app',
                        context),
                    style: TextStyle(fontSize: defaultFontSize(deviceInfo))),
                DefaultButton(
                    text: translatedWord('Activate now', context),
                    widget: requestingCode ? TrimLoadingWidget() : null,
                    onPressed: requestingCode
                        ? null
                        : () async {
                            await ActivateCubit.getInstance(context)
                                .requestActivationCode(emailOrPhone);
                          }),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
