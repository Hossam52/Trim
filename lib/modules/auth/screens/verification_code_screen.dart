import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/general_widgets/trim_text_field.dart';
import 'package:trim/modules/auth/cubits/activate_cubit.dart';
import 'package:trim/modules/auth/cubits/activate_states.dart';
import 'package:trim/modules/auth/widgets/not_correct_input.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class VerificationCodeScreen extends StatefulWidget {
  static const routeName = '/verification-code';
  const VerificationCodeScreen({
    Key key,
  }) : super(key: key);
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final int maxDigits = 5;
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String accessToken = ModalRoute.of(context).settings.arguments as String;
    return WillPopScope(
      onWillPop: () async {
        final res = await confirmBack(context);
        if (res != null && res) return Future.value(true);

        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(getWord('Verify account', context)),
              centerTitle: true,
            ),
            body: BlocConsumer<ActivateCubit, ActivateStates>(
              listener: (_, state) {
                if (state is RequestingNewActivatationCodeState)
                  accessToken = 'null';
                if (state is ValidActivateCodeStates)
                  Navigator.pop(context, true);
              },
              builder: (_, state) {
                if (state is RequestingNewActivatationCodeState)
                  return TrimLoadingWidget();
                if (state is ErrorRequestActivationCodeState)
                  return RetryWidget(text: state.error, onRetry: () {});
                bool checking = state is CheckingActivateCodeState;
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.png'),
                          radius: 70,
                        ),
                        if (state is ErrorActivateStates)
                          Container(
                              margin: const EdgeInsets.all(15.0),
                              child: ErrorWarning(text: state.error)),
                        Text(getWord('Enter verification code', context),
                            style: Theme.of(context).textTheme.button),
                        buildCodeField(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: buildActionButtons(
                              checking, context, accessToken),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Row buildActionButtons(
      bool checking, BuildContext context, String accessToken) {
    return Row(
      children: [
        Expanded(
          child: DefaultButton(
            text: getWord('Submit', context),
            onPressed: checking
                ? null
                : () {
                    if (formKey.currentState.validate())
                      ActivateCubit.getInstance(context)
                          .checkActivateCode(controller.text);
                  },
            widget: checking ? TrimLoadingWidget() : null,
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: DefaultButton(
            text: getWord('Reset', context),
            onPressed: checking
                ? null
                : () {
                    controller.text = '';
                    FocusScope.of(context).unfocus();
                  },
          ),
        ),
      ],
    );
  }

  Form buildCodeField() {
    return Form(
      key: formKey,
      child: TrimTextField(
        controller: controller,
        placeHolder: getWord('Recieved code', context),
        maxLength: maxDigits,
        inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        textInputType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        validator: (val) {
          if (val.isEmpty)
            return getWord('Recieved code can not be empty', context);
          if (val.length != maxDigits)
            return getWord('Code should be', context) + maxDigits.toString();
          return null;
        },
      ),
    );
  }
}
