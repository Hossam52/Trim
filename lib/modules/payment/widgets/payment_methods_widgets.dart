import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
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
            title: Text(getWord('Pay with cach', context)),
            groupValue: paymentMethod,
            value: PaymentMethod.Cash,
            selected: true,
            secondary: Image.asset('assets/icons/cash.png'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        Container(
          decoration: BoxDecoration(border: Border.symmetric()),
          child: RadioListTile<PaymentMethod>(
            onChanged: onChangeSelection,
            title: Text(getWord('Pay with VISA/MASTERCARD', context)),
            secondary: Image.asset('assets/icons/visa.png'),
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
