import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';

class AvailableTimes extends StatefulWidget {
  final void Function(int index) updateSelectedIndex;
  final List<String> availableDates;

  const AvailableTimes(
      {Key key,
      @required this.availableDates,
      @required this.updateSelectedIndex})
      : super(key: key);
  @override
  _AvailableDatesState createState() => _AvailableDatesState();
}

class _AvailableDatesState extends State<AvailableTimes> {
  int _timeSelectedIndex = 0;
  Widget _timeBuilder(int index, [bool timeSelected = false]) {
    final color = timeSelected ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        setState(() {
          _timeSelectedIndex = index;
          widget.updateSelectedIndex(_timeSelectedIndex);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(13.0),
        decoration: BoxDecoration(
            color: timeSelected ? Colors.black : Color(0xff96B9D4),
            borderRadius: BorderRadius.circular(roundedRadius)),
        child: Text(widget.availableDates[index],
            style: TextStyle(fontSize: defaultFontSize, color: color)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Available Dates',
              style: TextStyle(
                  fontSize: defaultFontSize, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 20,
              children: [
                ...List.generate(
                    widget.availableDates.length,
                    (index) => _timeSelectedIndex ==
                            index //means this time is selected
                        ? _timeBuilder(index, true)
                        : _timeBuilder(index)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
