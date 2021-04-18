import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
import 'package:trim/modules/home/widgets/trim_app_bar.dart';
import 'package:trim/widgets/transparent_appbar.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourite-screen';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                  itemCount: favouriteSalons.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          SalonLogo(
                              isFavorite: true,
                              height: height * 0.3,
                              imagePath: favouriteSalons[index].imagePath),
                          Positioned(
                            bottom: 20,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  favouriteSalons[index].salonName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.08,
                                      color: Colors.white),
                                ),
                                Container(
                                    width: width * 0.4,
                                    child: BuildStars(
                                        width: width / 1.5,
                                        stars:
                                            favouriteSalons[index].salonRate)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            TrimAppBar(),
          ],
        ),
      ),
    );
  }
}
