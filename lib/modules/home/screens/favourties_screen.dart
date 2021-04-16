import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/widgets/salon_logo.dart';
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
                                    child: buildStars(width, height,
                                        favouriteSalons[index].salonRate)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Container(
                width: double.infinity,
                child: Align(
                    heightFactor: 1,
                    alignment: Alignment.centerLeft,
                    child: BackButton(color: Colors.black)),
                color: Colors.grey[200].withAlpha(150)),
          ],
        ),
      ),
    );
  }

  Widget buildStars(double width, double height, double stars) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (starIndex) => Flexible(
          child: Container(
            margin: EdgeInsets.all(2),
            child: stars - (starIndex) == 0.5
                ? Icon(Icons.star_half_sharp,
                    color: Colors.yellow[800], size: width * 0.1)
                : starIndex + 1 > stars
                    ? Icon(Icons.star_outline_sharp, size: width * 0.1)
                    : Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                        size: width * 0.1,
                      ),
          ),
        ),
      ),
    );
  }
}
