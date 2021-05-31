import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class PriceInformation extends StatelessWidget {
  final String total;
  final String discount;
  final String totalAfterDiscount;

  const PriceInformation(
      {Key key,
      @required this.total,
      @required this.discount,
      @required this.totalAfterDiscount})
      : super(key: key);

  Widget reservationDetails(BuildContext context, DeviceInfo deviceInfo) {
    TextStyle style = TextStyle(fontSize: getFontSizeVersion2(deviceInfo));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getWord('total', context) + ': $total', style: style),
          Text(getWord('Discount', context) + ': $discount', style: style),
          Text(
              getWord('Total after discount', context) +
                  ': $totalAfterDiscount',
              style: style)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reservationDetails(context, deviceInfo),
        ],
      ),
    );
  }
}
