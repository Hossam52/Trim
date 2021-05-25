import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/cubit/cities_cubit.dart';
import 'package:trim/modules/home/cubit/cities_states.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/direction_map_screen.dart';
import 'package:trim/modules/home/screens/raters_screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';
import 'package:trim/general_widgets/default_button.dart';

import '../../../constants/app_constant.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = '/salon-detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocConsumer<SalonsCubit, SalonStates>(
              listener: (_, state) {},
              builder: (_, state) {
                if (state is LoadingSalonDetailState)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (state is ErrorSalonState)
                  return Center(child: Text('Error happened ${state.error}'));
                Salon salon = SalonsCubit.getInstance(context).salonDetail;
                return InfoWidget(
                  responsiveWidget: (context, deviceInfo) {
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        margin: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            SalonLogo(
                              showBottomName: true,
                              salon: salon,
                              deviceInfo: deviceInfo,
                              height:
                                  deviceInfo.orientation == Orientation.portrait
                                      ? deviceInfo.localHeight * 0.3
                                      : deviceInfo.localHeight * 0.6,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 18.0),
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: Openions(
                                        deviceInfo: deviceInfo,
                                        salon: salon,
                                      ),
                                      flex: 2),
                                  Expanded(
                                      child: availabilityTime(
                                          context, deviceInfo, salon)),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: addressWidget(
                                          context, deviceInfo, salon.address),
                                      flex: 3),
                                  Expanded(
                                      child: directionWidget(
                                          context, salon, deviceInfo))
                                ],
                              ),
                            ),
                            SalonServices(
                                services: salon.salonServices,
                                child: reserveButton(context, deviceInfo),
                                deviceInfo: deviceInfo),
                            SalonOffers(deviceInfo, salon.salonOffers),
                          ],
                        ),
                      ),
                    );
                  },
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
        padding: EdgeInsets.symmetric(
            horizontal: deviceInfo.localWidth / 5, vertical: 8.0),
        child: DefaultButton(
          color: Colors.black,
          textColor: Colors.white,
          fontSize: getFontSizeVersion2(deviceInfo),
          onPressed: () => reserveSalon(context, deviceInfo),
          text: getWord('Reserve now', context), //'Reserve now',
        ));
  }

  void reserveSalon(context, DeviceInfo deviceInfo) {
    SalonsCubit.getInstance(context).getAvilableDates(DateTime.now());
    Navigator.pushNamed(context, ReserveScreen.routeName,
        arguments: SalonDetailModel(
            showDateWidget: true,
            showAvailableTimes: true,
            showOffersWidget: true,
            showServiceWidget: false));
  }

  Widget addressWidget(
      BuildContext context, DeviceInfo deviceInfo, String address) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (address.isNotEmpty)
                ImageIcon(
                  AssetImage(pinIcon),
                ),
              Expanded(
                  child: Text(
                address.isEmpty
                    ? getWord("No Address is provided", context)
                    : address,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: true),
                style: TextStyle(
                  color: address.isEmpty ? Colors.red : null,
                  fontWeight: FontWeight.bold,
                  fontSize: getFontSizeVersion2(deviceInfo),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget directionWidget(
      BuildContext context, Salon salon, DeviceInfo deviceInfo) {
    return InkWell(
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () async {
            if (salon.lat == null ||
                salon.lat == "0" ||
                salon.lang == null ||
                salon.lang == "0") {
              Fluttertoast.showToast(
                  msg: 'Location for salon ${salon.name} is not provided');
            } else
              await MapsLauncher.launchCoordinates(salon.lat ?? 0,
                  salon.lang ?? 0, 'Google Headquarters are here');
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
                FittedBox(
                  child: Text(
                    getWord('Get directions', context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getFontSizeVersion2(deviceInfo)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget availabilityTime(
      BuildContext context, DeviceInfo deviceInfo, Salon salon) {
    final fontSize = deviceInfo.localWidth *
        (deviceInfo.type == deviceType.mobile ? 0.14 * 0.25 : 0.11 * 0.25);
    final openFrom = salon.openFrom == "" ? 'N/A' : salon.openFrom;
    final openTo = salon.openTo == "" ? "N/A" : salon.openTo;
    final to = getWord('To', context);

    return Card(
      elevation: 10,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          getWord('Open', context),
          style: TextStyle(
            color: Colors.green,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Flexible(
          child: Text('$openFrom $to $openTo',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}

class Openions extends StatelessWidget {
  final Salon salon;

  final DeviceInfo deviceInfo;
  const Openions({Key key, this.deviceInfo, @required this.salon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RatersScreen.routeName);
      },
      child: Card(
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, left: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BuildStars(
                  stars: salon.rate,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              Flexible(
                child: Text(
                  '${salon.commentsCount} ' + getWord('openions', context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getFontSizeVersion2(deviceInfo),
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
