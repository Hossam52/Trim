import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart' as constants;
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/home/screens/settings_screen.dart';
import 'package:trim/modules/home/screens/trimStars_Screen.dart';
import 'package:trim/modules/home/widgets/BuildButtonViewHome.dart';
import 'package:trim/modules/home/widgets/BuildListOffers.dart';
import 'package:trim/modules/home/widgets/BuildMostSearchedSalons.dart';
import 'package:trim/modules/home/widgets/BuildStarsPersonsList.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/app_dialog.dart';
import 'package:trim/modules/home/screens/ShoppingScreen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int initialIndex = 4;
  final heightNavigationBar = 50;
  List<Map<String, Widget>> pagesBuilder;
  bool showCategories = true;
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    pagesBuilder = [
      {'icon': Image.asset(settingsIcon), 'page': SettingsScreen()},
      {
        'icon': Image.asset(marketIcon),
        'page': ShoppingScreen(
          setCategoryIndex: setSelectedCategoryIndex,
        )
      },
      {'icon': Image.asset(locationIcon), 'page': MapScreen()},
      {'icon': Image.asset(hairIcon), 'page': SalonsScreen()},
      {
        'icon': Image.asset(haircutIcon),
        'page': BuildHomeWidget(heightNavigationBar: heightNavigationBar)
      },
    ];
  }

  void setSelectedCategoryIndex(int categoryIndex) {
    setState(() {
      print(categoryIndex);
      selectedCategoryIndex = categoryIndex;
      pagesBuilder[1]['page'] = CategoryProductsScreen(
        categoryIndex: categoryIndex,
        backToCategories: backToCategoires,
      );
      showCategories = false;
    });
  }

  void backToCategoires() {
    setState(() {
      showCategories = true;
      pagesBuilder[1]['page'] = ShoppingScreen(
        setCategoryIndex: setSelectedCategoryIndex,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (initialIndex != 4) {
          setState(() {
            initialIndex = 4;
          });
          return Future.value(false);
        } else {
          return await exitConfirmationDialog(context);
        }
      },
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: initialIndex,
          height: 50,
          color: Colors.grey[300],
          backgroundColor: Colors.white,
          items: pagesBuilder.map((widget) => widget['icon']).toList(),
          onTap: (index) {
            if (index == 1) {
              pagesBuilder[index]['page'] = showCategories
                  ? ShoppingScreen(
                      setCategoryIndex: setSelectedCategoryIndex,
                    )
                  : CategoryProductsScreen(
                      categoryIndex: selectedCategoryIndex,
                      backToCategories: backToCategoires,
                    );
            }
            setState(() {
              initialIndex = index;
            });
          },
        ),
        body: SafeArea(
          child: pagesBuilder[initialIndex]['page'],
        ),
      ),
    );
  }

  Widget selectedItem(int index) 
  {
    if (index == 0)
      return SettingsScreen();
    else if (index == 1)
      return ShoppingScreen();
    else if (index == 2)
      return MapScreen();
    else if (index == 3)
      return BuildHomeWidget(heightNavigationBar: heightNavigationBar);
    else if (index == 4)
      return SalonsScreen();
    else
      return Container();
  }
}

class BuildHomeWidget extends StatelessWidget {
  const BuildHomeWidget({
    @required this.heightNavigationBar,
  });
  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        double fontSize = constants.getFontSizeVersion2(deviceInfo);
        return Container(
          height: deviceInfo.localHeight,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: deviceInfo.orientation == Orientation.portrait
                      ? deviceInfo.localHeight / 3
                      : deviceInfo.localHeight / 2,
                  child: InfoWidget(
                    responsiveWidget: (context, de) {
                      return Container(
                        child: BuildOffersWidgetItem(
                            ),
                      );
                    },
                  ),
                ),
                BuildButtonView(
                  function: () {
                    Navigator.pushNamed(context, SalonsScreen.routeName,
                        arguments: {'hasBackButton': true});
                  },
                  //label: 'الأكثر بحثاً',
                  label: 'Most search',
                  textSize: fontSize,
                ),
                Container(
                  height: deviceInfo.orientation == Orientation.portrait
                      ? deviceInfo.localHeight / 3
                      : deviceInfo.localHeight,
                  child: BuildMostSearchedSalons(),
                ),
                BuildButtonView(
                  function: () {
                    Navigator.pushNamed(context, TrimStarsScreen.routeName);
                  },
                  // label: 'نجوم تريم',
                  label: 'Trim stars',
                  textSize: fontSize,
                ),
                Container(
                  height: deviceInfo.orientation == Orientation.portrait
                      ? deviceInfo.localHeight / 3
                      : deviceInfo.localHeight / 2,
                  child: BuildStarsPersonsWidget(
                      heightNavigationBar: heightNavigationBar),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}












