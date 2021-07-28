//In this file we keep the card layout for login and registration as both are same

import 'package:flutter/material.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import '../../../constants/app_constant.dart';

class CardLayout extends StatelessWidget {
  final List<Widget> children;

  const CardLayout({Key key, @required this.children}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Center(
                    child: Container(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: SafeArea(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 40),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    elevation: 20,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            deviceInfo.screenWidth * 0.05),
                                    child: Container(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(height: 50),
                                              ...children
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Center(child: Image.asset(logo)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
