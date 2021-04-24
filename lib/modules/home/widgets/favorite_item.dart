import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    Key key,
    @required this.favoriteSalon,
    @required this.width,
    @required this.deviceInfo,
  }) : super(key: key);

  final Salon favoriteSalon;
  final double width;
  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SalonDetailScreen.routeName,
            arguments: favoriteSalon);
      },
      child: Stack(
        children: [
          buildSalonLogo(),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSalonName(),
                buildSalonStars(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildSalonStars() {
    return Container(
      child: BuildStars(width: width / 1.8, stars: favoriteSalon.salonRate),
    );
  }

  Text buildSalonName() {
    return Text(
      favoriteSalon.salonName,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: getFontSizeVersion2(deviceInfo),
          color: Colors.white),
    );
  }

  SalonLogo buildSalonLogo() {
    return SalonLogo(
        showBottomName: false,
        deviceInfo: deviceInfo,
        height: deviceInfo.orientation == Orientation.portrait
            ? deviceInfo.localHeight * 0.3
            : deviceInfo.localHeight * 0.6,
        salon: favoriteSalon);
  }
}
