//In this file we keep the card layout for login and registration as both are same

import 'package:flutter/material.dart';
import '../../../constants/app_constant.dart';

class CardLayout extends StatelessWidget {
  final List<Widget> children;

  const CardLayout({Key key, @required this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
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
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [SizedBox(height: 50), ...children]),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(logoImagePath)),
            ],
          ),
        ),
      ),
    );
  }
}
