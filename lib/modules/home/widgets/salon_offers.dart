import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';

class SalonOffers extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final List<SalonOffer> salonOffers;
  SalonOffers(this.deviceInfo, this.salonOffers);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: salonOffers.isEmpty
          ? 0
          : deviceInfo.localHeight /
              (deviceInfo.orientation == Orientation.portrait ? 2.5 : 1.5),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return SalonOfferItem(
            offer: salonOffers[index],
            deviceInfo: deviceInfo,
          );
        },
        itemCount: salonOffers.length,
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
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        offer.descriptionEn,
                        style: TextStyle(
                          fontSize: getFontSizeVersion2(deviceInfo),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  );
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
              TrimCachedImage(
                src: offer.image,
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
