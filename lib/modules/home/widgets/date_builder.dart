import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class DateBuilder extends StatefulWidget {
  final void Function(DateTime selectedDate) onChangeDate;
  final DateTime initialSelectedDate;

  const DateBuilder(
      {Key key,
      @required this.onChangeDate,
      @required this.initialSelectedDate})
      : super(key: key);
  @override
  _DateBuilderState createState() => _DateBuilderState();
}

class _DateBuilderState extends State<DateBuilder> {
  final DateOperations dateOperations = DateOperations();
  List<DateTime> daysInMonth = [];
  DateTime displayedDate;
  DateTime now;
  String year;
  String month;
  DateTime selectedDate;
  final itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    final intialDate = widget.initialSelectedDate;
    displayedDate =
        intialDate; //For the date that appear like this < aug 20221 >
    selectedDate = intialDate;
    daysInMonth = dateOperations
        .generateDays(selectedDate); //All days displaed in specific month
    month = DateFormat('MMM').format(displayedDate);
    year = displayedDate.year.toString();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //To make the view of listview at the reservationdate
      setIndexDisplayedFirst(selectedDate.difference(daysInMonth.first).inDays);
    });
  }

  void setIndexDisplayedFirst(int index) {
    itemScrollController.jumpTo(index: index);
  }

  Widget buildDay(DateTime date, [bool selected = false]) {
    final String dayName = DateFormat('EEE').format(date);
    final String dayNumber = date.day.toString();
    final selectedColor = selected ? Colors.black : Colors.white;
    final TextStyle style =
        TextStyle(color: selectedColor, fontSize: defaultFontSize);
    return InkWell(
      onTap: () {
        setState(() {
          selectedDate = date;
        });
        widget.onChangeDate(date);
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
      daysInMonth = dateOperations.generateDays(displayedDate);
      month = DateFormat('MMM').format(displayedDate);
      year = displayedDate.year.toString();
      setIndexDisplayedFirst(0);
    });
  }

  void previousMonth() {
    if (displayedDate.year == now.year && displayedDate.month == now.month)
      return null; //can not go previous
    setState(() {
      displayedDate = dateOperations.getPreviousMonth(displayedDate);
      daysInMonth = dateOperations.generateDays(displayedDate);
      month = DateFormat('MMM').format(displayedDate);
      year = displayedDate.year.toString();
      setIndexDisplayedFirst(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: BackButton(
        color: Colors.black,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InfoWidget(
              responsiveWidget: (_, deviceInfo) => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    getWord('Select a suitable date', context),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: getFontSizeVersion2(deviceInfo)),
                  ),
                ],
              ),
            ),
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
            Expanded(
              child: ScrollablePositionedList.builder(
                itemScrollController: itemScrollController,
                itemCount: daysInMonth.length,
                itemBuilder: (_, index) {
                  final dateFormat = DateFormat(
                      'DDMMYYYY'); //To format both displaed and reservation date and know if specific date selected or not
                  if (dateFormat.format(daysInMonth[index]) ==
                      dateFormat.format(selectedDate))
                    return buildDay(selectedDate, true);
                  return buildDay(daysInMonth[index]);
                },
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
              ),
            )
          ],
        ),
      ),
      floating: false,
      pinned: false,
      backgroundColor: Color(0xff2C73A8),
      expandedHeight: 240,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(roundedRadius),
              bottomRight: Radius.circular(roundedRadius))),
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
      final displayedMonth = DateTime(date.year, date.month);
      List.generate(lastDayInMonth.day, (index) {
        dates.add(displayedMonth.add(Duration(days: index)));
      });
    }
    return dates;
  }
}
