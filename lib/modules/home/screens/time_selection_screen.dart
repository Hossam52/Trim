import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/date_builder.dart';
import 'package:trim/modules/home/widgets/price_information.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';
import 'package:trim/widgets/default_button.dart';
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
              SelectDateSliver(),
              SliverList(
                  delegate: SliverChildListDelegate.fixed([
                AvailableTimes(
                  updateSelectedIndex: updateTimeSelected,
                  availableDates: _availableTimes,
                ),
                Divider(),
                buildServices(),
                buildOffers(),
                PriceInformation(),
                DefaultButton(text: 'Reserve now')
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
