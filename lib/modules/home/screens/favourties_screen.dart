import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
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
    // TODO: implement initState
    super.initState();
    favoriteSalons = salonsData.where((salon) => salon.isFavorite).toList();
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, SalonDetailScreen.routeName,
                              arguments: favoriteSalons[index]);
                        },
                        child: Stack(
                          children: [
                            SalonLogo(
                                showBottomName: false,
                                // salonName: favoriteSalons[index].salonName,
                                deviceInfo: deviceInfo,
                                // isFavorite: true,
                                height: deviceInfo.orientation ==
                                        Orientation.portrait
                                    ? deviceInfo.localHeight * 0.3
                                    : deviceInfo.localHeight * 0.6,
                                // imagePath:
                                //     'assets/images/${favoriteSalons[index].imagePath}.jpg'
                                salon: favoriteSalons[index]),
                            Positioned(
                              bottom: 20,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    favoriteSalons[index].salonName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width * 0.05,
                                        color: Colors.white),
                                  ),
                                  Container(
                                      child: BuildStars(
                                          width: width / 1.8,
                                          stars:
                                              favoriteSalons[index].salonRate)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            TrimAppBar(),
          ],
        ),
      );
    }));
  }
}
