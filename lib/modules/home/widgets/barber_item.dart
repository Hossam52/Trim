import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/favorite_container.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class BarberItem extends StatelessWidget {
  final Barber barber;
  final DeviceInfo deviceInfo;

  const BarberItem({Key key, @required this.deviceInfo, @required this.barber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, DetailsScreen.routeName);
          },
          child: GridTile(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage(barber.image), fit: BoxFit.fill)),
            ),
            footer: Container(
              color: Colors.grey[200].withAlpha(155),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    barber.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: getFontSizeVersion2(deviceInfo),
                        fontWeight: FontWeight.bold),
                  ),
                  BuildStars(
                      stars: barber.rate, width: deviceInfo.localWidth / 1.8)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: deviceInfo.localWidth *
              (deviceInfo.orientation == Orientation.portrait ? 0.08 : 0.06),
          child: FavoriteContainer(
            isFavorite: barber.isFavorite,
            deviceInfo: deviceInfo,
          ),
        )
      ],
    );
  }
}
