import 'package:flutter/material.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/price_information.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/default_button.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';

class ReserveScreen extends StatelessWidget {
  static const routeName = '/reserve-screen';
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
  Widget buildOffers(DeviceInfo deviceInfo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SalonOffers(deviceInfo),
    );
  }

  Widget buildServices() {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SalonServices(deviceInfo: deviceInfo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SalonDetailModel model =
        ModalRoute.of(context).settings.arguments as SalonDetailModel;
    final selectDateWidget = model.showDateWidget;
    final availableDatesWidget = model.showAvailableTimes;
    final servicesWidget = model.showServiceWidget;
    final offersWidget = model.showOffersWidget;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: InfoWidget(
          responsiveWidget: (context, deviceInfo) => SafeArea(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                if (selectDateWidget != false) SelectDateSliver(),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    if (selectDateWidget == false)
                      Align(
                          alignment: Alignment.centerLeft, child: BackButton()),
                    if (availableDatesWidget != false)
                      AvailableTimes(
                        availableDates: _availableTimes,
                        updateSelectedIndex: (index) {},
                      ),
                    if (selectDateWidget != false ||
                        availableDatesWidget != false)
                      Divider(),
                    if (servicesWidget != false) buildServices(),
                    if (offersWidget != false) buildOffers(deviceInfo),
                    PriceInformation(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: DefaultButton(
                        text: 'Reserve now',
                        onPressed: () {},
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
