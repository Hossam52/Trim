import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/widgets/trim_text_field.dart';

class PriceInformation extends StatelessWidget {
  Widget getCopunTextField() {
    return TrimTextField(
      controller: TextEditingController(),
      readOnly: true,
      placeHolder: '#####',
      prefix: ElevatedButton(
        onPressed: () {
          print('hello');
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

  Widget reservationDetails() {
    int totalPrice = 400;
    int discount = 20;
    int afterDiscount = totalPrice - (totalPrice * discount / 100).floor();
    TextStyle style = TextStyle(fontSize: defaultFontSize);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCopunTextField(),
        reservationDetails(),
      ],
    );
  }
}
