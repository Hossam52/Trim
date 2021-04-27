import 'package:flutter/material.dart';
import 'package:trim/modules/payment/widgets/build_details_order_price.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class DeliveryWidget extends StatefulWidget {
  DeliveryWidget(
      {@required this.fontSize,
      @required this.secondaryColor,
      @required this.stepNumber,
      @required this.pressed,
      @required this.deviceInfo});

  final double fontSize;
  final Color secondaryColor;
  final Function pressed;
  int stepNumber;
  final DeviceInfo deviceInfo;

  @override
  _DeliveryWidgetState createState() => _DeliveryWidgetState();
}

class _DeliveryWidgetState extends State<DeliveryWidget> {
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
            onPressed: () {},
            child: Text('غير'),
          ),
          trailing: Text(
            'تفاصيل العنوان',
            style: TextStyle(
                fontSize: widget.fontSize - 5, color: widget.secondaryColor),
          ),
        ),
        Container(
          height: widget.deviceInfo.localHeight *
              (widget.deviceInfo.orientation == Orientation.portrait
                  ? 0.265
                  : .7),
          //widget.deviceInfo.localHeight * 0.265,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ahmed ashraf',
                  style: TextStyle(
                      fontSize: widget.fontSize, color: Colors.black)),
              Text(
                '60 شارع عمار بن ياسر شبرا الخيمة',
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
                '+201069826459',
                style: TextStyle(
                    fontSize: widget.fontSize - 5,
                    color: widget.secondaryColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            'اختيار طريقة التوصيل',
            style: TextStyle(
                fontSize: widget.fontSize - 5, color: Color(0xffCBCBCD)),
          ),
        ),
        Container(
          height: widget.deviceInfo.localHeight *
              (widget.deviceInfo.orientation == Orientation.portrait
                  ? 0.22
                  : .45),
          //  widget.deviceInfo.localHeight * 0.22,
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
                'تسليم الى المنزل',
                style: TextStyle(fontSize: widget.fontSize - 3),
              ),
              subtitle: Column(
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
                        'مصاريف الشحن :',
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
                        '40',
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
        SizedBox(
          height: 10,
        ),
        BuildDetailsOrderPrice(
          stepNumber: widget.stepNumber,
          fontSize: widget.fontSize,
          deviceInfo: widget.deviceInfo,
          pressed: widget.pressed,
        ),
      ],
    );
  }
}
