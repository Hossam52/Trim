import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/market/models/StepsCompleteOrder.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/market/widgets/build_delivery_widget.dart';
import 'package:trim/modules/market/widgets/build_details_order_price.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static final String routeName = 'confirmOrderScreen';

  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  int stepNumber = 1;

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
                height: deviceInfo.localHeight *
                    (deviceInfo.orientation == Orientation.portrait
                        ? 0.15
                        : .35),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                      ),
                      title: Text(
                        'انهاء الطلب',
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
                            label: stepsCompleteOrder[0],
                            textColor:
                                stepNumber != 1 ? secondaryColor : Colors.white,
                            color: stepNumber == 1
                                ? Colors.lightBlueAccent
                                : Colors.white,
                            fontSize: fontSize,
                          ),
                          BuildStepOrder(
                            label: stepsCompleteOrder[1],
                            textColor:
                                stepNumber != 2 ? secondaryColor : Colors.white,
                            color: stepNumber == 2
                                ? Colors.lightBlueAccent
                                : Colors.white,
                            fontSize: fontSize,
                          ),
                          BuildStepOrder(
                            label: stepsCompleteOrder[2],
                            textColor:
                                stepNumber != 3 ? secondaryColor : Colors.white,
                            color: stepNumber == 3
                                ? Colors.lightBlueAccent
                                : Colors.white,
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
                            children: [
                              Text('اختيار طريقة الدفع'),
                              Card(
                                child: ListTile(
                                  leading: Radio(
                                    value: '2',
                                    groupValue: '2',
                                    onChanged: (val) {
                                      setState(() {
                                        if (val == '2')
                                          showDetails = true;
                                        else
                                          showDetails = false;
                                      });
                                    },
                                  ),
                                  title: Text('طريقة الدفع'),
                                  subtitle: !showDetails
                                      ? Container()
                                      : Text('واحدة من احسن طرق الدفع حاليا'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  leading: Radio(
                                    value: '1',
                                    groupValue: '2',
                                    onChanged: (val) {},
                                  ),
                                  title: Text('طريقة الدفع'),
                                ),
                              ),
                              BuildDetailsOrderPrice(
                                  fontSize: fontSize,
                                  pressed: () {
                                    setState(() {
                                      if (stepNumber < 3) stepNumber++;
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
  BuildStepOrder({this.label, this.color, this.fontSize, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize - 5, color: textColor),
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
