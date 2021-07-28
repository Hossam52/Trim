import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class CouponsScreen extends StatelessWidget {
  static const routeName = '/coupons';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translatedWord('Coupons', context),
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
          ResponsiveWidget(
            responsiveWidget: (_, deviceInfo) => Text(
                'Dicsount of your invoice',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: defaultFontSize(deviceInfo))),
          ),
          SizedBox(height: 50),
          Image.asset(
            horizontalIcon,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          ResponsiveWidget(
            responsiveWidget: (_, deviceInfo) => Text(
                translatedWord('Discount code', context),
                style: TextStyle(
                    fontSize: defaultFontSize(deviceInfo),
                    color: Colors.white)),
          ),
          _buildDiscountAmount(),
          _buildAvailableUntil(),
        ],
      ),
    );
  }

  Widget _buildInvoiceBackground() {
    return Image.asset(colorIngeridents,
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
                style: TextStyle(fontSize: defaultFontSize(DeviceInfo()))),
          )),
        ),
      );
    });
  }

  Widget _buildAvailableUntil() {
    return ResponsiveWidget(
        responsiveWidget: (_, deviceInfo) => Text(
            'This code valid until: ${1}/${9}',
            style: TextStyle(
                fontSize: defaultFontSize(deviceInfo), color: Colors.white)));
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
          Image.asset(teamIcon, width: 100, height: 100, fit: BoxFit.fill),
          SizedBox(width: 10),
          Flexible(
            child: ResponsiveWidget(
                responsiveWidget: (_, deviceInfo) => Text(
                    'Share App with your firends and get copouns',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: defaultFontSize(deviceInfo)))),
          )
        ],
      ),
    );
  }
}
