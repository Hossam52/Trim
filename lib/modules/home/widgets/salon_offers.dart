import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_offer.dart';

class SalonOffers extends StatelessWidget {
  final List<SalonOffer> offers = [
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription:
            'Bride offer and to their friends and so beautiful girl that i want'),
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription: 'Bride offer and to their friends'),
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription: 'Bride offer and to their friends'),
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription: 'Bride offer and to their friends'),
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription: 'Bride offer and to their friends'),
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription: 'Bride offer and to their friends'),
    SalonOffer(
        imagePath: 'assets/images/1.jpg',
        offerDiscription: 'Bride offer and to their friends'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return SalonOfferItem(
            offer: offers[index],
          );
        },
        itemCount: offers.length,
      ),
    );
  }
}

class SalonOfferItem extends StatelessWidget {
  final SalonOffer offer;

  const SalonOfferItem({Key key, this.offer}) : super(key: key);

  Widget actionsBuilder(context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                DateTime now = DateTime.now().subtract(Duration(days: 60));
                DateTime last = DateTime(now.year, now.month + 1, 0);
                print(last);
              },
              child: Text(
                'Details',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text('Reserve'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(roundedRadius),
          topLeft: Radius.circular(roundedRadius),
        ),
        child: Card(
          elevation: 10.0,
          child: Column(
            children: [
              Image.asset(offer.imagePath, fit: BoxFit.fitWidth),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(offer.offerDiscription),
              ),
              actionsBuilder(context),
            ],
          ),
        ),
      ),
    );
  }
}
