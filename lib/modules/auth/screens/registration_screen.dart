import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../constants/app_constant.dart';
import '../widgets/form_fields.dart';

enum Gender {
  Male,
  Female,
}

class RegistrationScreen extends StatefulWidget {
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  Widget _alreadyHasAccount = TextButton(
    onPressed: () {},
    child: Text(
      'هل لديك حساب بالفعل؟',
      style: TextStyle(color: Colors.grey, fontSize: 20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double _viewCardHeight =
        mediaQuery.size.height - kToolbarHeight - mediaQuery.padding.top;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Container(
                  height: _viewCardHeight,
                  child: Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 20,
                        margin: const EdgeInsets.all(30),
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: 40),
                                FormFields(),
                                _alreadyHasAccount,
                                Text('أو يمكنك التسجيل من خلال'),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        icon: Image.asset(facebookImagePath),
                                        onPressed: () {}),
                                    IconButton(
                                        icon: Image.asset(googleImagePath),
                                        onPressed: () {}),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(logoImagePath));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
