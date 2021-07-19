import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class AvailableTimes extends StatelessWidget {
  final List<String> dates;
  final int selectedIndex;
  final void Function(int) onDateChange;
  const AvailableTimes(
      {Key key,
      @required this.dates,
      @required this.selectedIndex,
      @required this.onDateChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(getWord('Available Dates', context),
                style: TextStyle(
                    fontSize: getFontSizeVersion2(deviceInfo) * 0.8,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10,
                runSpacing: 20,
                children: List.generate(
                    dates.length,
                    (index) =>
                        _timeBuilder(context, dates[index], index, deviceInfo)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeBuilder(
      BuildContext context, String date, int index, DeviceInfo deviceInfo) {
    final color = selectedIndex == index ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        onDateChange(index);
      },
      child: Container(
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.black : Color(0xff96B9D4),
            borderRadius: BorderRadius.circular(roundedRadius)),
        child: Text(date,
            style: TextStyle(
                fontSize: getFontSizeVersion2(deviceInfo) * 0.7, color: color)),
      ),
    );
  }
}
