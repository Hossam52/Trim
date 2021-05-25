import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/modules/payment/cubits/payment_states.dart';

class PaymentDetailScreen extends StatefulWidget {
  static const String routeName = '/payment-detail';

  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final creditKey = GlobalKey<FormState>();
  bool dialogIsShow = false;
  @override
  void initState() {
    super.initState();
    PaymentCubit.getInstance(context).clearCreditCardData();
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        ModalRoute.of(context).settings.arguments as double ?? 0;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                PaymentCubit.getInstance(context).successPayment = false;
                Navigator.pop(context);
              },
            ),
            title: Text('CREDITCARD DATA'),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: false,
          body: WillPopScope(
            onWillPop: () {
              PaymentCubit.getInstance(context).successPayment = false;
              return Future.value(true);
            },
            child: BlocConsumer<PaymentCubit, PaymentStates>(
              listener: (_, state) async {
                if (state is ErrorPaymentState) {
                  if (dialogIsShow) {
                    dialogIsShow = false;
                    Navigator.pop(context);
                  }
                  await Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_SHORT,
                      msg: state.errorMessage,
                      backgroundColor: Colors.red,
                      gravity: ToastGravity.BOTTOM);
                }
                if (state is LoadedTokenState) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text(
                                'Card is valid and you will pay $totalPrice EGP Are you sure to continue?'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              PaymentCubit.getInstance(context)
                                  .makePayment(totalPrice.toInt());
                              Navigator.pop(context);
                            },
                            child: Text('Yes',
                                style: TextStyle(color: Colors.green))),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('NO',
                                style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  );
                }
                if (state is LoadingPaymentState) {
                  dialogIsShow = true;
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),
                  );
                }
                if (state is LoadedPaymentState) {
                  dialogIsShow = false;
                  await Fluttertoast.showToast(
                      msg: 'Your Payment done successifully',
                      backgroundColor: Colors.green);
                  int counter = 0;
                  Navigator.popUntil(context, (_) => counter++ == 3);
                }
              },
              builder: (_, state) {
                final card = PaymentCubit.getInstance(context).cardModel;
                return Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    CreditCardWidget(
                      cardNumber: card.cardNumber,
                      expiryDate: card.expiryDate,
                      cardHolderName: card.cardHolderName,
                      cvvCode: card.cvvCode,
                      showBackView: card.isCvvFocused,
                      height: 180,
                      width: 305,
                      animationDuration: Duration(milliseconds: 1000),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: CreditCardForm(
                          onCreditCardModelChange:
                              PaymentCubit.getInstance(context)
                                  .changeCreditCardData,
                          cardHolderName: card.cardHolderName,
                          cardNumber: card.cardNumber,
                          cvvCode: card.cvvCode,
                          expiryDate: card.expiryDate,
                          formKey: creditKey,
                          themeColor: Colors.red,
                        ),
                      ),
                    ),
                    DefaultButton(
                        text: getWord('Validate and pay', context),
                        widget: state is LoadingTokenState
                            ? Center(child: CircularProgressIndicator())
                            : null,
                        onPressed: () {
                          if (creditKey.currentState.validate())
                            PaymentCubit.getInstance(context).payService(1000);
                        })
                  ],
                );
              },
            ),
          )),
    );
  }
}
