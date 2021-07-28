import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/wallet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translatedWord('My wallet', context),
              style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.black),
        ),
        body: ResponsiveWidget(
          responsiveWidget: (context, deviceInfo) {
            bool isPortrait =
                deviceInfo.orientation == Orientation.portrait ? true : false;
            return Container(
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Container(
                width: deviceInfo.localWidth / 1.3,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: deviceInfo.localHeight * (isPortrait ? 0.3 : 0.4),
                      child: Image.asset(
                        walletIcon,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      height:
                          deviceInfo.localHeight * (isPortrait ? 0.25 : 0.35),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffBED5E3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          ResponsiveWidget(
                            responsiveWidget: (_, deviceInfo) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Text(
                                        translatedWord(
                                            'Total amount in your wallet',
                                            context),
                                        style: TextStyle(
                                            fontSize:
                                                defaultFontSize(deviceInfo)))),
                                Text('${0.0} EGP',
                                    style: TextStyle(
                                        fontSize: defaultFontSize(deviceInfo),
                                        color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
