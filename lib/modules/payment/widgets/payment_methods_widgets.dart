import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';

class PaymentMethodsWidget extends StatelessWidget {
  final bool showCashMethod;
  final PaymentMethod paymentMethod;
  final void Function(PaymentMethod) onChangeSelection;
  const PaymentMethodsWidget(
      {Key key,
      @required this.showCashMethod,
      @required this.paymentMethod,
      @required this.onChangeSelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showCashMethod)
          RadioListTile<PaymentMethod>(
            onChanged: onChangeSelection,
            title: Text(translatedWord('Pay with cach', context)),
            groupValue: paymentMethod,
            value: PaymentMethod.Cash,
            selected: true,
            secondary: Image.asset(cashIcon),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        Container(
          decoration: BoxDecoration(border: Border.symmetric()),
          child: RadioListTile<PaymentMethod>(
            onChanged: onChangeSelection,
            title: Text(translatedWord('Pay with VISA/MASTERCARD', context)),
            secondary: Image.asset(visaIcon),
            groupValue: paymentMethod,
            value: PaymentMethod.VisaMaster,
            selected: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
