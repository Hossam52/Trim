import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/screens/direction_map_screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/screens/time_selection_screen.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';
import 'package:trim/widgets/transparent_appbar.dart';

class SalonDetailScreen extends StatelessWidget {
  static const String routeName = '/salon-detail';

  Widget reserveButton(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
          ),
          onPressed: () => reserveSalon(context),
          child: const Text('Reserve now')),
    );
  }

  void reserveSalon(context) {
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
    Navigator.pushNamed(context, ReserveScreen.routeName, arguments: {
      'selectDateWidget': SelectDateSliver(),
      'availableDatesWidget': AvailableTimes(
        availableDates: _availableTimes,
        updateSelectedIndex: (index) {},
      ),
      'servicesWidget': SalonServices(),
      'offersWidget': SalonOffers()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              SalonLogo(
                isFavorite: false,
                height: 200,
                imagePath: 'assets/images/2.jpg',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: Openions(), flex: 2),
                      Expanded(child: availabilityTime),
                    ],
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: addressWidget, flex: 3),
                    Expanded(child: directionWidget(context))
                  ],
                ),
              ),
              SalonServices(child: reserveButton(context)),
              SalonOffers(),
            ],
          ),
        ),
      ),
    );
  }

  final Widget addressWidget = Card(
    elevation: 10,
    child: InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(pinIcon),
            ),
            Expanded(
                child: Text('Ibrahime saqr, tagoa el 3 beside tawla cafee')),
          ],
        ),
      ),
    ),
  );

  Widget directionWidget(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, DirectionMapScreen.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ImageIcon(
                  AssetImage(locationIcon),
                  color: Colors.blue,
                  size: 50,
                ),
                Text('Get directions'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Widget availabilityTime = Card(
    elevation: 10,
    child: Column(
      children: [
        Text('Open', style: TextStyle(color: Colors.green)),
        Text('11:00 am', style: TextStyle(color: Colors.green)),
        Text('To'),
        Text('10:00 pm', style: TextStyle(color: Colors.green))
      ],
    ),
  );
}

class Openions extends StatelessWidget {
  Widget starsBuilder(int stars) {
    List<Widget> allStars = List.generate(
        stars,
        (index) => Image.asset(
              starIcon,
            ));
    allStars
        .addAll(List.generate(5 - stars, (index) => Icon(Icons.star_border)));
    return Row(
      children: allStars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            starsBuilder(5),
            FittedBox(child: Text('20 openions'), fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}
