import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/constants/app_constant.dart' as constants;
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/home/screens/settings_screen.dart';
import 'package:trim/modules/home/screens/trimStars_Screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
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

  Widget selectedItem(int index) {
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
                            heightNavigationBar: heightNavigationBar),
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

class BuildStarsPersonsWidget extends StatelessWidget {
  const BuildStarsPersonsWidget({
    @required this.heightNavigationBar,
  });

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveFlutter.of(context).scale(200) - heightNavigationBar,
      child: ListView.builder(
        itemCount: barbers.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => BuildStarPersonItem(
          barber: barbers[index],
        ),
      ),
    );
  }
}

class BuildStarPersonItem extends StatelessWidget {
  final Barber barber;

  const BuildStarPersonItem({Key key, @required this.barber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        personDetailsDialog(context, barber);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7),
        width: MediaQuery.of(context).size.width / 3.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(
                barber.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber.name,
                  style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  height: ResponsiveFlutter.of(context).scale(17),
                  child: BuildStars(
                      width: MediaQuery.of(context).size.width / 2,
                      stars: barber.stars),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class BuildMostSearchedSalons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        print(deviceInfo.localHeight);
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(2),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                "assets/images/${salonsData[index].imagePath}.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            childAspectRatio:
                (deviceInfo.localWidth / (deviceInfo.localHeight) / 1.5),
          ),
        );
      },
    );
  }
}

class BuildOffersWidgetItem extends StatelessWidget {
  const BuildOffersWidgetItem({
    Key key,
    @required this.heightNavigationBar,
  }) : super(key: key);

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ResponsiveFlutter.of(context).scale(2)),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: CarouselSlider.builder(
        options: CarouselOptions(
            autoPlay: true, enlargeCenterPage: true, aspectRatio: 2.9),
        itemCount: 3,
        itemBuilder: (context, index, _) => BuildOffersItem(),
      ),
    );
  }
}

class BuildButtonView extends StatelessWidget {
  final Function function;
  final String label;
  final textSize;
  BuildButtonView({this.function, this.label, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
            onPressed: function,
            child: Text(
              label,
              style: TextStyle(fontSize: textSize),
            )));
  }
}

class BuildOffersItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/barber.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
      Positioned(
          bottom: 30,
          child: Container(
              padding: EdgeInsets.all(4),
              child: Text(
                  // 'عرض   50%   لفترة محدودة '
                  'Limited offer 50%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              decoration: BoxDecoration(
                color: Color(0xff676363).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ))),
    ]);
  }
}
