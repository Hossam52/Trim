import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/favorite_item.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/transparent_appbar.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/favourite-screen';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Salon> favoriteSalons;
  @override
  void initState() {
    super.initState();
    getFavoriteSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: InfoWidget(responsiveWidget: (context, deviceInfo) {
      final width = deviceInfo.localWidth;
      return SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: favoriteSalons.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FavoriteItem(
                          favoriteSalon: favoriteSalons[index],
                          deviceInfo: deviceInfo,
                          width: width),
                    );
                  }),
            ),
            TrimAppBar(),
          ],
        ),
      );
    }));
  }

  void getFavoriteSalons() {
    favoriteSalons = salonsData.where((salon) => salon.isFavorite).toList();
  }
}
