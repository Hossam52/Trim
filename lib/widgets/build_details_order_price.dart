import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/StepsCompleteOrder.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/build_listTile_confirm.dart';
class BuildDetailsOrderPrice extends StatelessWidget {
  BuildDetailsOrderPrice(
      {@required this.fontSize,
      @required this.pressed,
      @required this.deviceInfo,
      @required this.stepNumber});

  final double fontSize;
  final DeviceInfo deviceInfo ;
  final Function pressed;
  final int stepNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:deviceInfo.localHeight *(deviceInfo.orientation==Orientation.portrait?  0.40:0.75),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildListTileCofirm(
            leading: 'الاجمالي',
            trailing: '447 جنيه',
            fontSize: fontSize,
          ),
          BuildListTileCofirm(
            leading: 'الشحن',
            trailing: '447 جنيه',
            fontSize: fontSize,
          ),
          Divider(
            endIndent: 10,
            height: 4,
            color: Colors.black,
          ),
          BuildListTileCofirm(
            leading: 'السعر الكلي',
            trailing: '447 جنيه',
            fontSize: fontSize,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: pressed,
              child: Text('المواصلة في ${stepsCompleteOrder[stepNumber - 1]}',
                  style: TextStyle(fontSize: fontSize)),
            ),
          ),
        ],
      ),
    );
  }
}