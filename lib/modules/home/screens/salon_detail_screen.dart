import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/screens/time_selection_screen.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
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
    Navigator.pushNamed(context, TimeSelectionScreen.routeName);
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
              SalonLogo(),
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
                    Expanded(child: getDirections)
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
              AssetImage('assets/icons/pin.png'),
            ),
            Expanded(
                child: Text('Ibrahime saqr, tagoa el 3 beside tawla cafee')),
          ],
        ),
      ),
    ),
  );

  final Widget getDirections = InkWell(
    child: Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ImageIcon(
                AssetImage('assets/icons/location.png'),
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
              'assets/icons/star.png',
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
