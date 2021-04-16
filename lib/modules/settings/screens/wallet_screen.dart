import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class WalletScreen extends StatelessWidget {
  static const routeName = '/wallet';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('My wallet', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/wallet-pro.png'),
            Container(
              margin: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: 100,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigo[200],
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
                                    fontSize: getFontSize(deviceInfo)))),
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
  }
}
