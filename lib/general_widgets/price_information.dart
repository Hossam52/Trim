import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/settings/screens/coupons_screen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/trim_text_field.dart';

class PriceInformation extends StatelessWidget {
  final String total;
  final String discount;
  final String totalAfterDiscount;
  final bool showCopounsField;

  const PriceInformation(
      {Key key,
      this.showCopounsField = true,
      @required this.total,
      @required this.discount,
      @required this.totalAfterDiscount})
      : super(key: key);
  Widget getCopunTextField(BuildContext context) {
    return TrimTextField(
      controller: TextEditingController(),
      readOnly: true,
      placeHolder: '#####',
      prefix: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, CouponsScreen.routeName);
        },
        child: Text(getWord('Get coupon', context)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff2C73A8)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }

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
          if (showCopounsField) getCopunTextField(context),
          reservationDetails(context, deviceInfo),
        ],
      ),
    );
  }
}
