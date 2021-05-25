import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_text_field.dart';
import 'package:trim/modules/payment/widgets/build_details_order_price.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class DeliveryWidget extends StatefulWidget {
  DeliveryWidget({
    @required this.fontSize,
    @required this.secondaryColor,
    @required this.stepNumber,
    @required this.pressed,
    @required this.deviceInfo,
    @required this.addressController,
    @required this.phoneController,
  });

  final double fontSize;
  final Color secondaryColor;
  final Function pressed;
  int stepNumber;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final DeviceInfo deviceInfo;

  @override
  _DeliveryWidgetState createState() => _DeliveryWidgetState();
}

class _DeliveryWidgetState extends State<DeliveryWidget> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: TextButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
              TextStyle(
                  fontSize: widget.fontSize - 5, color: Colors.lightBlueAccent),
            )),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              
                              TrimTextField(
                                controller: widget.addressController,
                                placeHolder: getWord('Enter your address', context),
                                validator: (address) {
                                  if (address.isEmpty)
                                    return getWord('Enter your address', context);
                                  return null;
                                },
                              ),
                              TrimTextField(
                                controller: widget.phoneController,
                                textInputType: TextInputType.phone,
                                placeHolder: 'Enter your phone',
                                validator: (phone) {
                                  if (phone.isEmpty)
                                    return getWord('Please Enter Your Phone', context);
                                  else if (phone.length < 11)
                                    return getWord('Please Enter Valid Number', context);
                                  return null;
                                },
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('address',
                                        widget.addressController.text);
                                    prefs.setString(
                                        'phone', widget.phoneController.text);

                                    Navigator.pop(
                                        context, widget.phoneController.text);
                                  }
                                },
                                child: Text(getWord('save', context)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Text(getWord('change', context)),
          ),
          trailing: Text(
            getWord('address details', context),
            style: TextStyle(
                fontSize: widget.fontSize - 5, color: widget.secondaryColor),
          ),
        ),
        Container(
          height: widget.deviceInfo.localHeight *
              (widget.deviceInfo.orientation == Orientation.portrait
                  ? 0.265
                  : .7),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ahmed ashraf',
                    style: TextStyle(
                        fontSize: widget.fontSize, color: Colors.black)),
                Text(
                  '${widget.addressController.text}',
                  style: TextStyle(
                      fontSize: widget.fontSize - 5,
                      color: widget.secondaryColor),
                ),
                Text(
                  'القليوبية',
                  style: TextStyle(
                      fontSize: widget.fontSize - 5,
                      color: widget.secondaryColor),
                ),
                Text('شبرا الخيمة',
                    style: TextStyle(
                        fontSize: widget.fontSize - 5,
                        color: widget.secondaryColor)),
                Text(
                  '${widget.phoneController.text}',
                  style: TextStyle(
                      fontSize: widget.fontSize - 5,
                      color: widget.secondaryColor),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            getWord('choice deliver method', context),
            style: TextStyle(
                fontSize: widget.fontSize - 5, color: Color(0xffCBCBCD)),
          ),
        ),
        Container(
          height: widget.deviceInfo.localHeight *
              (widget.deviceInfo.orientation == Orientation.portrait
                  ? 0.22
                  : .45),
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              leading: Radio(
                value: '1',
                groupValue: '1',
                onChanged: (val) {},
              ),
              title: Text(
                getWord('delivery to home', context),
                style: TextStyle(fontSize: widget.fontSize - 3),
              ),
              subtitle: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        '.يصل اليك بين يوم الاربعاء أبريل /28 والخميس أبريل /29 يرجى التحقق من التواريخ المحددة في صفحة متابعة الشراء',
                        style: TextStyle(
                          fontSize: widget.deviceInfo.orientation ==
                                  Orientation.portrait
                              ? widget.deviceInfo.localWidth * 0.032
                              : widget.deviceInfo.localWidth * 0.0225,
                        )),
                    Row(
                      children: [
                        Text(
                          getWord('Shipping expenses', context) + ' :',
                          style: TextStyle(
                            fontSize: widget.deviceInfo.orientation ==
                                    Orientation.portrait
                                ? widget.deviceInfo.localWidth * 0.032
                                : widget.deviceInfo.localWidth * 0.0225,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '20',
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.fontSize - 4),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DefaultButton(
            text: getWord('Continue to pay', context),
            onPressed: widget.pressed),
      ],
    );
  }
}
