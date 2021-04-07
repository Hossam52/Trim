import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/date_builder.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/widgets/trim_text_field.dart';

class TimeSelectionScreen extends StatelessWidget {
  static const routeName = '/time-selection';

  final List<String> _availableTimes = [
    '07:00 pm',
    '12:00am',
    '01:00pm',
    '07:00 pm',
    '12:00am',
    '01:00pm',
    '07:00 pm',
    '12:00am',
    '01:00pm'
  ];

  int selectedTimeIndex = 0;

  void updateTimeSelected(int index) {
    selectedTimeIndex = index;
    print(index);
  }

  Widget getCopunTextField() {
    return TrimTextField(
      controller: TextEditingController(),
      placeHolder: '#####',
      prefix: ElevatedButton(
        onPressed: () {
          print('hello');
        },
        child: Text('Get coupon'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff2C73A8)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }

  Widget reservationDetails() {
    int totalPrice = 400;
    int discount = 20;
    int afterDiscount = totalPrice - (totalPrice * discount / 100).floor();
    TextStyle style = TextStyle(fontSize: defaultFontSize);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total: $totalPrice', style: style),
          Text('Discount: $discount', style: style),
          Text('Total after dicount: $afterDiscount', style: style)
        ],
      ),
    );
  }

  Widget reserveNow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Reserve now'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff2C73A8)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOffers() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SalonOffers(),
    );
  }

  Widget buildServices() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SalonServices(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Select a suitable date',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                leading: BackButton(
                  color: Colors.black,
                ),
                flexibleSpace: DateBuilder(),
                floating: false,
                pinned: false,
                backgroundColor: Color(0xff2C73A8),
                expandedHeight: 230,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(roundedRadius),
                        bottomRight: Radius.circular(roundedRadius))),
              ),
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                AvailableTimes(
                  updateSelectedIndex: updateTimeSelected,
                  availableDates: _availableTimes,
                ),
                Divider(),
                buildServices(),
                buildOffers(),
                getCopunTextField(),
                reservationDetails(),
                reserveNow(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
