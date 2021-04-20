import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/wallet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My wallet', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.black),
        ),
        body: InfoWidget(
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
                        'assets/icons/wallet-pro.png',
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
                          InfoWidget(
                            responsiveWidget: (_, deviceInfo) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    child: Text('Total amount in your wallet',
                                        style: TextStyle(
                                            fontSize:
                                                getFontSize(deviceInfo)))),
                                Text('${0.0} EGP',
                                    style: TextStyle(
                                        fontSize: getFontSize(deviceInfo),
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
