import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trim/modules/auth/widgets/not_correct_input.dart';
import 'package:trim/utils/services/verification_code_service.dart';
import 'package:trim/widgets/transparent_appbar.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class VerificationCodeScreen extends StatefulWidget {
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  String errorMessage = 'Enter  valid numbers';
  bool correctData = true;

  Widget digitTextField(int index, FocusScopeNode node,
          [bool lastDigit = false]) =>
      Expanded(
        child: Container(
          margin: const EdgeInsets.all(7.0),
          child: TextField(
            controller: _controllers[index],
            maxLength: 1,
            autofocus: index == 0 ? true : false,
            textAlign: TextAlign.center,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            onEditingComplete: !lastDigit ? () => node.nextFocus() : null,
            onSubmitted: (_) => lastDigit ? node.unfocus() : null,
            onChanged: (String value) {
              if (value.length == 1) {
                node.nextFocus();
              } else if (value.length == 0) {
                node.previousFocus();
              }
            },
            textInputAction:
                !lastDigit ? TextInputAction.next : TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              counterText: "",
            ),
          ),
        ),
      );

  Widget digits(FocusNode node) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(
        children: [
          digitTextField(0, node),
          digitTextField(1, node),
          digitTextField(2, node),
          digitTextField(3, node),
          digitTextField(4, node, true),
        ],
      ),
    );
  }

  Widget button({String text, VoidCallback onPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (!correctData)
              setState(() {
                correctData = true;
              });
            onPressed();
          },
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: TransparentAppBar(),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 70,
                ),
                if (!correctData)
                  Container(
                      margin: const EdgeInsets.all(15.0),
                      child: ErrorWarning(text: errorMessage)),
                Text('Enter verification code',
                    style: Theme.of(context).textTheme.button),
                digits(node),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      button(
                          text: 'Submit',
                          onPressed: () {
                            String userEnteredVerificationCode = "";
                            for (var controller in _controllers) {
                              if (controller.text.isEmpty) {
                                setState(() {
                                  correctData = false;
                                });
                                return;
                              }
                              userEnteredVerificationCode += controller.text;
                            }
                            ActivationProcessServices()
                                .getVerificationCode("01115425561", "1234567")
                                .then((value) {
                              if (value.error)
                                setState(() {
                                  correctData = false;
                                  errorMessage = value.errorMessage;
                                });
                              else {
                                print(value.data);
                                setState(() {
                                  ActivationProcessServices()
                                      .activate(userEnteredVerificationCode);
                                  if (userEnteredVerificationCode ==
                                      value.data) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('VerificationCode is correct'),
                                    ));
                                    correctData = true;
                                  } else
                                    correctData = false;
                                  errorMessage =
                                      'VerificationCode is inccorect';
                                });
                              }
                            });
                          }),
                      button(
                          text: 'Reset',
                          onPressed: () {
                            setState(() {
                              for (TextEditingController controller
                                  in _controllers) {
                                controller.text = "";
                              }
                              FocusScope.of(context).unfocus();
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
