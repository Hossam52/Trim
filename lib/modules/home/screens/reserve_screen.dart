import 'package:flutter/material.dart';
import 'package:trim/modules/home/widgets/price_information.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';
import 'package:trim/widgets/default_button.dart';

class ReserveScreen extends StatelessWidget {
  static const routeName = '/reserve-screen';

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
    Map<String, Widget> data =
        ModalRoute.of(context).settings.arguments as Map<String, Widget>;
    final selectDateWidget = data['selectDateWidget'];
    final availableDatesWidget = data['availableDatesWidget'];
    final servicesWidget = data['servicesWidget'];
    final offersWidget = data['offersWidget'];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              if (selectDateWidget != null) SelectDateSliver(),
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  if (availableDatesWidget != null) availableDatesWidget,
                  if (selectDateWidget == null)
                    Align(alignment: Alignment.centerLeft, child: BackButton()),
                  if (selectDateWidget != null || availableDatesWidget != null)
                    Divider(),
                  if (servicesWidget != null) buildServices(),
                  if (offersWidget != null) buildOffers(),
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
    );
  }
}
