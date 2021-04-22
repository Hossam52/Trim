import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/screens/direction_map_screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/widgets/default_button.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/transparent_appbar.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';

class SalonDetailScreen extends StatelessWidget {
  static const String routeName = '/salon-detail';
  @override
  Widget build(BuildContext context) {
    Salon salonData = ModalRoute.of(context).settings.arguments as Salon;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InfoWidget(
              responsiveWidget: (context, deviceInfo) {
                return SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          SalonLogo(
                            showBottomName: true,
                            salon: salonData,
                            deviceInfo: deviceInfo,
                            height:
                                deviceInfo.orientation == Orientation.portrait
                                    ? deviceInfo.localHeight * 0.3
                                    : deviceInfo.localHeight * 0.6,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Openions(
                                        deviceInfo: deviceInfo,
                                        salonData: salonData,
                                      ),
                                      flex: 2),
                                  Expanded(child: availabilityTime(deviceInfo)),
                                ],
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: addressWidget(
                                        deviceInfo, salonData.address),
                                    flex: 3),
                                Expanded(
                                    child: directionWidget(context, deviceInfo))
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
                  ),
                );
              },
            ),
            TrimAppBar(),
          ],
        ),
      ),
    );
  }

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
    Navigator.pushNamed(context, ReserveScreen.routeName,
        arguments: SalonDetailModel(
            showDateWidget: true,
            showAvailableTimes: true,
            showOffersWidget: true,
            showServiceWidget: false));
  }

  Widget addressWidget(DeviceInfo deviceInfo, String address) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(pinIcon),
              ),
              Expanded(
                  child: Text(
                address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: true),
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
                Flexible(
                  child: Text(
                    'Get directions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: deviceInfo.localWidth *
                            (deviceInfo.type == deviceType.mobile
                                ? 0.15 * 0.25
                                : 0.13 * 0.25)),
                  ),
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
    );
  }
}

class Openions extends StatelessWidget {
  final Salon salonData;

  final DeviceInfo deviceInfo;
  const Openions({Key key, this.deviceInfo, @required this.salonData})
      : super(key: key);

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
            Expanded(
              child: BuildStars(
                stars: salonData.salonRate,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
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
