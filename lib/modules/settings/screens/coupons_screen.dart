import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class CouponsScreen extends StatelessWidget {
  static const routeName = '/coupons';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getWord('Coupons', context),
            style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  _buildInvoiceBackground(),
                  Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: _buildDicountWidget(context)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {},
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    backgroundGradient(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: shareAppWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDicountWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${20} %', style: Theme.of(context).textTheme.headline2),
          InfoWidget(
            responsiveWidget: (_, deviceInfo) => Text(
                'Dicsount of your invoice',
                style: TextStyle(
                    color: Colors.white, fontSize: getFontSize(deviceInfo))),
          ),
          SizedBox(height: 50),
          Image.asset(
            'assets/icons/horizontal.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          InfoWidget(
            responsiveWidget: (_, deviceInfo) => Text(
                getWord('Discount code', context),
                style: TextStyle(
                    fontSize: getFontSize(deviceInfo), color: Colors.white)),
          ),
          _buildDiscountAmount(),
          _buildAvailableUntil(),
        ],
      ),
    );
  }

  Widget _buildInvoiceBackground() {
    return Image.asset('assets/icons/color-ingeridants.png',
        width: double.infinity, height: double.infinity, fit: BoxFit.fill);
  }

  Widget _buildDiscountAmount() {
    return LayoutBuilder(builder: (_, constraints) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: const EdgeInsets.all(20),
          width: constraints.maxWidth / 2,
          child: Center(
              child: FittedBox(
            child: Text('#######',
                style: TextStyle(fontSize: getFontSize(DeviceInfo()))),
          )),
        ),
      );
    });
  }

  Widget _buildAvailableUntil() {
    return InfoWidget(
        responsiveWidget: (_, deviceInfo) => Text(
            'This code valid until: ${1}/${9}',
            style: TextStyle(
                fontSize: getFontSize(deviceInfo), color: Colors.white)));
  }

  Widget backgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey]),
      ),
    );
  }

  Widget shareAppWidget() {
    return GestureDetector(
      onTap: () async {
        await Share.share('trim.style');
        await DioHelper.postData(
          url: 'winCoupone',
        );
      },
      child: Row(
        children: [
          Image.asset('assets/icons/team.png',
              width: 100, height: 100, fit: BoxFit.fill),
          SizedBox(width: 10),
          Flexible(
            child: InfoWidget(
                responsiveWidget: (_, deviceInfo) => Text(
                    'Share App with your firends and get copouns',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getFontSize(deviceInfo)))),
          )
        ],
      ),
    );
  }
}
