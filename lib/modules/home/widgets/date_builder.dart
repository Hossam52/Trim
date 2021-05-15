import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';

class DateBuilder extends StatefulWidget {
  @override
  _DateBuilderState createState() => _DateBuilderState();
}

class _DateBuilderState extends State<DateBuilder> {
  final DateOperations dateOperations = DateOperations();
  List<DateTime> days = [];
  DateTime displayedDate;
  DateTime now;
  String year;
  String month;
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    displayedDate = DateTime.now();
    days = dateOperations.generateDays(now);
    month = DateFormat('MMM').format(now);
    year = now.year.toString();
    // selectedDayIndex = 0;
    print(SalonsCubit.getInstance(context).selectedDateIndex);
    selectedDayIndex = SalonsCubit.getInstance(context).selectedDateIndex;
  }

  Widget buildDay(int index, [bool selected = false]) {
    final String dayName = DateFormat('EEE').format(days[index]);
    final String dayNumber = days[index].day.toString();
    final selectedColor = selected ? Colors.black : Colors.white;
    final TextStyle style =
        TextStyle(color: selectedColor, fontSize: defaultFontSize);
    return InkWell(
      onTap: () {
        setState(() {
          selectedDayIndex = index;
        });
        SalonsCubit.getInstance(context)
            .getAvilableDates(days[selectedDayIndex]);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration:
            !selected // if the current day is not selected make no decoration
                ? null
                : BoxDecoration(
                    color: Color(0xff96B9D4),
                    borderRadius: BorderRadius.circular(roundedRadius)),
        child: Column(
          children: [
            Text(dayNumber, style: style),
            Text(dayName, style: style),
          ],
        ),
      ),
    );
  }

  void nextMonth() {
    setState(() {
      displayedDate = dateOperations.getNextMonth(displayedDate);
      days = dateOperations.generateDays(displayedDate);
      month = DateFormat('MMM').format(displayedDate);
      year = displayedDate.year.toString();
      selectedDayIndex = 0;
    });
  }

  void previousMonth() {
    if (displayedDate.year == now.year && displayedDate.month == now.month)
      return null; //can not go previous
    setState(() {
      displayedDate = dateOperations.getPreviousMonth(displayedDate);
      days = dateOperations.generateDays(displayedDate);
      month = DateFormat('MMM').format(displayedDate);
      year = displayedDate.year.toString();
      selectedDayIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  onPressed: previousMonth,
                ),
                Text('$month  $year',
                    style: TextStyle(
                        color: Colors.white, fontSize: defaultFontSize)),
                IconButton(
                    disabledColor: Colors.red,
                    icon: Icon(Icons.arrow_forward_ios_sharp,
                        color: Colors.white),
                    onPressed: nextMonth)
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(days.length, (index) {
                    if (index == selectedDayIndex) return buildDay(index, true);
                    return buildDay(index);
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateOperations {
  DateTime getNextMonth(DateTime date) {
    DateTime lastDay = getLastMonthDay(date);
    DateTime nextMonth = lastDay.add(Duration(days: 1));
    return nextMonth;
  }

  DateTime getLastMonthDay(DateTime date) {
    DateTime lastDay = DateTime(date.year, date.month + 1, 0);
    return lastDay;
  }

  DateTime getPreviousMonth(DateTime date) {
    return DateTime(date.year, date.month - 1, date.day);
  }

  List<DateTime> generateDays(DateTime date) {
    DateTime now = DateTime.now();
    DateTime lastDayInMonth = getLastMonthDay(date);

    List<DateTime> dates = [];
    if (date.year == now.year && date.month == now.month) {
      int day = 0;

      for (int i = now.day; i <= lastDayInMonth.day; i++) {
        dates.add(now.add(Duration(days: day++)));
      }
    } else {
      List.generate(lastDayInMonth.day, (index) {
        dates.add(date.add(Duration(days: index)));
      });
    }
    return dates;
  }
}
