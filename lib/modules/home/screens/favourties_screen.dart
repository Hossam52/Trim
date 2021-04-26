import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/choice_button.dart';
import 'package:trim/modules/home/widgets/favorite_item.dart';
import 'package:trim/modules/home/widgets/persons_grid_view.dart';
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
  bool displaySalons = true;
  @override
  void initState() {
    super.initState();
    getFavoriteSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: InfoWidget(
        responsiveWidget: (context, deviceInfo) {
          final width = deviceInfo.localWidth;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: buildSalonPersonsButtons(),
                ),
                Expanded(
                    child: displaySalons
                        ? ListView.builder(
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
                            })
                        : PersonsGridView(
                            filterFavorite: true,
                          )),
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildSalonPersonsButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceButton(
          directionRoundedRight: false,
          icon: hairIcon,
          name: 'Salons',
          active: displaySalons,
          pressed: () {
            if (!displaySalons)
              setState(() {
                displaySalons = true;
              });
          },
        ),
        ChoiceButton(
          directionRoundedRight: true,
          icon: marketIcon,
          name: 'Persons',
          active: !displaySalons,
          pressed: () {
            if (displaySalons)
              setState(() {
                displaySalons = false;
              });
          },
        ),
      ],
    );
  }

  void getFavoriteSalons() {
    favoriteSalons = salonsData.where((salon) => salon.isFavorite).toList();
  }
}
