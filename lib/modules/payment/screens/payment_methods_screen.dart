import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/payment/widgets/payment_methods_widgets.dart';
import '../cubits/payment_cubit.dart';
import '../cubits/payment_states.dart';
import './payment_detail_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  static const String routeName = '/payment-methods';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final showCashMethod = arguments['showCashMethod'] ?? true;
    double totalPrice = arguments['totalPrice'] ?? 0;
    return WillPopScope(
      onWillPop: () {
        PaymentCubit.getInstance(context).successPayment = false;
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              PaymentCubit.getInstance(context).successPayment = false;
              Navigator.pop(context);
            },
          ),
          title: Text(getWord('Select Payment Methods', context)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<PaymentCubit, PaymentStates>(
            buildWhen: (_, state) {
              if (state is ChangePaymentMethodState) return true;
              return false;
            },
            builder: (_, state) {
              final PaymentMethod paymentMethod =
                  PaymentCubit.getInstance(context).paymentMethod;
              return Column(
                children: [
                  PaymentMethodsWidget(
                      onChangeSelection: PaymentCubit.getInstance(context)
                          .changeSelectedPaymentMethod,
                      showCashMethod: showCashMethod,
                      paymentMethod: paymentMethod),
                  Spacer(),
                  DefaultButton(
                      text: getWord('Pay Now', context) + ' $totalPrice EGP',
                      onPressed: () {
                        if (paymentMethod == PaymentMethod.Cash) {
                          PaymentCubit.getInstance(context).successPayment =
                              true;
                          Navigator.pop(context);
                        } else {
                          if (paymentMethod == PaymentMethod.VisaMaster)
                            Navigator.pushNamed(
                                context, PaymentDetailScreen.routeName,
                                arguments: totalPrice);
                        }
                      })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
