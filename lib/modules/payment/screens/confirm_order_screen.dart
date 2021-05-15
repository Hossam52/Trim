import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/payment/widgets/build_delivery_widget.dart';
import 'package:trim/modules/payment/widgets/build_details_order_price.dart';
import 'package:trim/general_widgets/default_button.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static final String routeName = 'confirmOrderScreen';

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  int stepNumber = 1;
  PaymentMethod paymentMethod = PaymentMethod.VisaMaster;
  Color secondaryColor = Color(0xffCBCBCD);
  bool showDetails = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: InfoWidget(responsiveWidget: (context, deviceInfo) {
        double fontSize = getFontSizeVersion2(deviceInfo);
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: IconButton(
                        iconSize: deviceInfo.localWidth *
                            (deviceInfo.orientation == Orientation.portrait
                                ? 0.07
                                : 0.06),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                      title: Text(
                        getWord('Confirm order', context),
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 4, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BuildStepOrder(
                            onPressed: () {
                              if (stepNumber != 1)
                                setState(() {
                                  stepNumber = 1;
                                });
                            },
                            label: getWord('delivery', context),
                            textColor:
                                stepNumber != 1 ? secondaryColor : Colors.white,
                            color: stepNumber == 1
                                ? Colors.blue[800]
                                : Colors.white,
                            isActive: true,
                            fontSize: fontSize,
                          ),
                          SizedBox(width: 30),
                          BuildStepOrder(
                            onPressed: () {},
                            label: getWord('payment', context),
                            textColor:
                                stepNumber != 2 ? secondaryColor : Colors.white,
                            color: stepNumber == 2
                                ? Colors.blue[800]
                                : Colors.white,
                            isActive: stepNumber == 2,
                            fontSize: fontSize,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: stepNumber == 1
                        ? DeliveryWidget(
                            fontSize: fontSize,
                            secondaryColor: secondaryColor,
                            stepNumber: stepNumber,
                            deviceInfo: deviceInfo,
                            pressed: () {
                              if (stepNumber < 3) {
                                setState(() {
                                  stepNumber++;
                                });
                              }
                            },
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getWord('choice payment method', context),
                                style: TextStyle(fontSize: fontSize),
                              ),
                              Card(
                                child: ListTile(
                                  leading: Radio<PaymentMethod>(
                                    value: PaymentMethod.VisaMaster,
                                    groupValue: paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value;
                                      });
                                    },
                                  ),
                                  title: Text(
                                    getWord('payment from card', context),
                                    style: TextStyle(fontSize: fontSize),
                                  ),
                                  subtitle:
                                      paymentMethod != PaymentMethod.VisaMaster
                                          ? Container()
                                          : Text(getWord(
                                              'one of the best payment way now',
                                              context)),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  leading: Radio<PaymentMethod>(
                                    value: PaymentMethod.Cash,
                                    groupValue: paymentMethod,
                                    onChanged: (value) {
                                      setState(() {
                                        paymentMethod = value;
                                      });
                                    },
                                  ),
                                  title: Text(
                                      getWord(
                                          'payment when recieving', context),
                                      style: TextStyle(fontSize: fontSize)),
                                  subtitle: paymentMethod != PaymentMethod.Cash
                                      ? Container()
                                      : Text(getWord(
                                          'payment when recieving', context)),
                                ),
                              ),
                              BuildDetailsOrderPrice(
                                  paymentMethod: paymentMethod,
                                  fontSize: fontSize,
                                  pressed: () {
                                    setState(() {
                                      if (stepNumber < 2) stepNumber++;
                                    });
                                  },
                                  deviceInfo: deviceInfo,
                                  stepNumber: stepNumber)
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class BuildStepOrder extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String label;
  final double fontSize;
  final bool isActive;
  final VoidCallback onPressed;
  BuildStepOrder(
      {this.label,
      this.color,
      this.fontSize,
      this.textColor,
      this.isActive = false,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultButton(
      color: color,
      fontSize: fontSize - 5,
      textColor: textColor,
      onPressed: isActive == false ? null : onPressed,
      text: label,
    ));
  }
}
