import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/settings/screens/coupons_screen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/trim_text_field.dart';

class PriceInformation extends StatelessWidget {
  final bool showCopounsField;

  const PriceInformation({Key key, this.showCopounsField = true})
      : super(key: key);
  Widget getCopunTextField(BuildContext context) {
    return TrimTextField(
      controller: TextEditingController(),
      readOnly: true,
      placeHolder: '#####',
      prefix: ElevatedButton(
        onPressed: () {
          print('hello');
          Navigator.pushNamed(context, CouponsScreen.routeName);
        },
        child: Text('Get coupon'),
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

  Widget reservationDetails(DeviceInfo deviceInfo) {
    int totalPrice = 400;
    int discount = 20;
    int afterDiscount = totalPrice - (totalPrice * discount / 100).floor();
    TextStyle style = TextStyle(fontSize: getFontSizeVersion2(deviceInfo));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total: $totalPrice', style: style),
          Text('Discount: $discount', style: style),
          Text('Total after dicount: $afterDiscount', style: style)
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
          reservationDetails(deviceInfo),
        ],
      ),
    );
  }
}
