import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart' as constants;
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/models/home_model.dart';
import 'package:trim/modules/market/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/settings/screens/settings_screen.dart';
import 'package:trim/modules/home/screens/raters_screen.dart';
import 'package:trim/modules/home/widgets/BuildButtonViewHome.dart';
import 'package:trim/modules/home/widgets/BuildListOffers.dart';
import 'package:trim/modules/home/widgets/BuildMostSearchedSalons.dart';
import 'package:trim/modules/home/widgets/BuildStarsPersonsList.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/app_dialog.dart';
import 'package:trim/modules/market/screens/ShoppingScreen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final heightNavigationBar = 50;
  int initialIndex = 4;
  bool showCategories = true;
  int selectedCategoryIndex = 0;
  final Color selectedIconColor = Colors.blue[900];
  List<PageWidget> pagesBuilder;
  @override
  void initState() {
    super.initState();
    HomeCubit.getInstance(context).loadHomeLayout(context);

    pagesBuilder = [
      PageWidget(imageIcon: settingsIcon, page: SettingsScreen()),
      PageWidget(
          imageIcon: marketIcon,
          page: ShoppingScreen(setCategoryIndex: setSelectedCategoryIndex)),
      PageWidget(imageIcon: locationIcon, page: MapScreen()),
      PageWidget(imageIcon: hairIcon, page: SalonsScreen()),
      PageWidget(
          imageIcon: haircutIcon,
          page: BuildHomeWidget(
            heightNavigationBar: heightNavigationBar,
          )),
    ];
  }

  void setSelectedCategoryIndex(int categoryIndex) {
    setState(() {
      print(categoryIndex);
      selectedCategoryIndex = categoryIndex;
      pagesBuilder[1].page = CategoryProductsScreen(
        categoryIndex: categoryIndex,
        backToCategories: backToCategoires,
      );
      showCategories = false;
    });
  }

  void backToCategoires() {
    setState(() {
      showCategories = true;
      pagesBuilder[1].page = ShoppingScreen(
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
          return false;
        } else {
          return await exitConfirmationDialog(context, 'Are you sure to exit?');
        }
      },
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (_, state) => (state is LoadingHomeState)
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                bottomNavigationBar: Directionality(
                  textDirection: TextDirection.ltr,
                  child: CurvedNavigationBar(
                    index: initialIndex,
                    height: 50,
                    color: Colors.grey[300],
                    backgroundColor: Colors.white,
                    items: List.generate(
                        pagesBuilder.length,
                        (index) => index == initialIndex
                            ? pagesBuilder[index].selectedIcon
                            : pagesBuilder[index].unselectedIcon),
                    onTap: (index) {
                      if (index == 1) {
                        pagesBuilder[index].page = showCategories
                            ? ShoppingScreen(
                                setCategoryIndex: setSelectedCategoryIndex,
                              )
                            : CategoryProductsScreen(
                                categoryIndex: selectedCategoryIndex,
                                backToCategories: backToCategoires,
                              );
                      }
                      if (index == 3) //All Salons set type
                      {
                        HomeCubit.getInstance(context).emit(AllSalonsState());
                        // temp = Temp.All;
                      }
                      setState(() {
                        initialIndex = index;
                      });
                    },
                  ),
                ),
                body: SafeArea(
                  child: pagesBuilder[initialIndex].page,
                ),
              ),
      ),
    );
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
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildMainListOffers(deviceInfo),
                  BuildButtonView(
                    function:
                        HomeCubit.getInstance(context).navigateToMostSearch,
                    label: getWord('Most search', context),
                    textSize: fontSize,
                  ),
                  Container(
                    height: deviceInfo.orientation == Orientation.portrait
                        ? deviceInfo.localHeight / 3
                        : deviceInfo.localHeight,
                    child: BuildMostSearchedSalons(),
                  ),
                  BuildButtonView(
                    function:
                        HomeCubit.getInstance(context).navigateToTrimStars,
                    label: getWord('Trim stars', context),
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
          ),
        );
      },
    );
  }

  Container buildMainListOffers(DeviceInfo deviceInfo) {
    return Container(
      height: deviceInfo.orientation == Orientation.portrait
          ? deviceInfo.localHeight / 3
          : deviceInfo.localHeight / 2,
      child: InfoWidget(
        responsiveWidget: (context, de) {
          return Container(
            child: BuildOffersWidgetItem(),
          );
        },
      ),
    );
  }
}

class PageWidget {
  Widget page;
  final String imageIcon;
  PageWidget({@required this.page, @required this.imageIcon})
      : selectedIcon =
            ImageIcon(AssetImage(imageIcon), size: 30, color: Colors.blue[900]),
        unselectedIcon = ImageIcon(
          AssetImage(imageIcon),
          size: 30,
        );

  final ImageIcon selectedIcon;
  final ImageIcon unselectedIcon;
}
