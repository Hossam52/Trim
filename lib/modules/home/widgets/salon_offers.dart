import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonOffers extends StatelessWidget {
  final DeviceInfo deviceInfo;
  SalonOffers(this.deviceInfo);
  final List<SalonOffer> offers = [
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn:
            'Bride offer and to their friends and so beautiful girl that i want'),
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn: 'Bride offer and to their friends'),
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn: 'Bride offer and to their friends'),
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn: 'Bride offer and to their friends'),
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn: 'Bride offer and to their friends'),
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn: 'Bride offer and to their friends'),
    SalonOffer(
        image: 'assets/images/1.jpg',
        descriptionEn: 'Bride offer and to their friends'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceInfo.localHeight /
          (deviceInfo.orientation == Orientation.portrait ? 2.5 : 1.5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return SalonOfferItem(
            offer: offers[index],
            deviceInfo: deviceInfo,
          );
        },
        itemCount: offers.length,
      ),
    );
  }
}

class SalonOfferItem extends StatelessWidget {
  final SalonOffer offer;
  final DeviceInfo deviceInfo;

  const SalonOfferItem({Key key, this.offer, this.deviceInfo})
      : super(key: key);

  Widget actionsBuilder(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  DateTime now = DateTime.now().subtract(Duration(days: 60));
                  DateTime last = DateTime(now.year, now.month + 1, 0);
                  print(last);
                },
                child: FittedBox(
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: FittedBox(child: Text('Reserve')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = deviceInfo.orientation == Orientation.portrait;
    double containerWidth = deviceInfo.localWidth / 2;
    double fontSize =
        isPortrait ? containerWidth * 0.085 : containerWidth * 0.07;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: containerWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(roundedRadius),
          topLeft: Radius.circular(roundedRadius),
        ),
        child: Card(
          elevation: 10.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                offer.image,
                fit: BoxFit.fill,
                height: deviceInfo.localHeight / (isPortrait ? 4.3 : 2.9),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  offer.descriptionEn,
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              actionsBuilder(context),
            ],
          ),
        ),
      ),
    );
  }
}
