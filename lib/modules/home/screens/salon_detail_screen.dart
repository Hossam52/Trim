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
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/transparent_appbar.dart';

class SalonDetailScreen extends StatelessWidget {
  static const String routeName = '/salon-detail';

  Widget reserveButton(context, DeviceInfo deviceInfo) {
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
          onPressed: () => reserveSalon(context, deviceInfo),
          child: const Text('Reserve now')),
    );
  }

  void reserveSalon(context, DeviceInfo deviceInfo) {
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
      'servicesWidget': SalonServices(
        deviceInfo: deviceInfo,
      ),
      'offersWidget': SalonOffers(deviceInfo)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentAppBar(),
        body: InfoWidget(
          responsiveWidget: (context, deviceInfo) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    SalonLogo(
                      deviceInfo: deviceInfo,
                      isFavorite: false,
                      height: deviceInfo.orientation == Orientation.portrait
                          ? deviceInfo.localHeight * 0.3
                          : deviceInfo.localHeight * 0.6,
                      imagePath: 'assets/images/2.jpg',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: Openions(deviceInfo), flex: 2),
                            Expanded(child: availabilityTime(deviceInfo)),
                          ],
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: addressWidget(deviceInfo), flex: 3),
                          Expanded(child: directionWidget(context, deviceInfo))
                        ],
                      ),
                    ),
                    SalonServices(
                        child: reserveButton(context, deviceInfo),
                        deviceInfo: deviceInfo),
                    SalonOffers(deviceInfo),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget addressWidget(DeviceInfo deviceInfo) {
    return Card(
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
                  child: Text(
                'Ibrahime saqr, tagoa el 3 beside tawla cafee',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceInfo.localWidth *
                      (deviceInfo.type == deviceType.mobile
                          ? 0.075 * 0.75
                          : 0.042 * 0.75),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget directionWidget(BuildContext context, DeviceInfo deviceInfo) {
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
                Text(
                  'Get directions',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceInfo.localWidth *
                          (deviceInfo.type == deviceType.mobile
                              ? 0.15 * 0.25
                              : 0.13 * 0.25)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget availabilityTime(DeviceInfo deviceInfo) {
    final fontSize = deviceInfo.localWidth *
        (deviceInfo.type == deviceType.mobile ? 0.14 * 0.25 : 0.11 * 0.25);
    return Card(
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Open',
            style: TextStyle(
              color: Colors.green,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '11:00 am',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ' To ',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '10:00 pm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Openions extends StatelessWidget {
  final DeviceInfo deviceInfo;
  Openions(this.deviceInfo);

  Widget starsBuilder(int stars) {
    bool isPortrait = deviceInfo.orientation == Orientation.portrait;
    double heightStar = isPortrait
        ? deviceInfo.localHeight * 0.07
        : deviceInfo.localHeight * 0.16;
    List<Widget> allStars = List.generate(
        stars,
        (index) => Image.asset(
              starIcon,
              height: heightStar * 0.45,
              fit: BoxFit.cover,
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
        padding: const EdgeInsets.only(right: 10, left: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            starsBuilder(5),
            Flexible(
              child: Text(
                '20 openions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (deviceInfo.localWidth *
                      (deviceInfo.type == deviceType.mobile
                          ? 0.063 * 0.75
                          : 0.04 * 0.75)),
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
