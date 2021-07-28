import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart' as constants;
import 'package:trim/constants/asset_path.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/settings/screens/settings_screen.dart';
import 'package:trim/modules/home/widgets/BuildButtonViewHome.dart';
import 'package:trim/modules/home/widgets/BuildListOffers.dart';
import 'package:trim/modules/home/widgets/BuildMostSearchedSalons.dart';
import 'package:trim/modules/home/widgets/BuildStarsPersonsList.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/app_dialog.dart';
import 'package:trim/modules/market/screens/ShoppingScreen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool showCategories = true;
  final Color selectedIconColor = Colors.blue[900];
  bool launchMap = false;
  int initialIndex = 4;
  List<PageWidget> pagesBuilder = [];

  @override
  void initState() {
    super.initState();
    pagesBuilder
        .add(PageWidget(imageIcon: appSettingsIcon, page: SettingsScreen()));
    pagesBuilder.add(PageWidget(imageIcon: marketIcon, page: ShoppingScreen()));
    pagesBuilder.add(PageWidget(imageIcon: locationIcon, page: MapScreen()));
    pagesBuilder.add(PageWidget(imageIcon: hairIcon, page: SalonsScreen()));
    pagesBuilder.add(PageWidget(
        imageIcon: haircutIcon,
        page: BuildHomeWidget(
          heightNavigationBar: 50,
        )));

    WidgetsBinding.instance.addObserver(this);
    HomeCubit.getInstance(context).loadHomeLayout(context);
  }

  @override
  void dispose() async {
    super.dispose();
  }

  List<Widget> bottomBarItems() {
    List<Widget> list = [];
    for (int i = 0; i < pagesBuilder.length; i++) {
      if (i == initialIndex)
        list.add(pagesBuilder[i].selectedIcon);
      else
        list.add(pagesBuilder[i].unselectedIcon);
    }
    return list;
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
            return await exitConfirmationDialog(
                context, translatedWord('Are you sure to exit?', context));
          }
        },
        child: Scaffold(
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.ltr,
            child: CurvedNavigationBar(
              index: initialIndex,
              height: 50,
              color: Colors.grey[300],
              backgroundColor: Colors.white,
              items: bottomBarItems(),
              onTap: (index) {
                if (index == 2) {
                  SalonsCubit.getInstance(context).loadNearestSalons(31, 31.5);
                }
                if (index == 3) {
                  //All Salons set type
                  HomeCubit.getInstance(context).emit(AllSalonsState());
                }
                setState(() {
                  initialIndex = index;
                });
              },
            ),
          ),
          body: SafeArea(child: pagesBuilder[initialIndex].page),
        ));
  }
}

class BuildHomeWidget extends StatelessWidget {
  const BuildHomeWidget({
    @required this.heightNavigationBar,
  });
  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(builder: (_, state) {
      if (state is LoadingHomeState) return TrimLoadingWidget();
      if (state is ErrorHomeState)
        return Material(child: retryWidget(state.error, context));
      if (HomeCubit.getInstance(context).homeModel == null)
        return Material(
            child: retryWidget(
                translatedWord('Un expected error happened', context),
                context));
      return ResponsiveWidget(
        responsiveWidget: (context, deviceInfo) {
          double fontSize = constants.defaultFontSize(deviceInfo) * 0.8;
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
                      label: translatedWord('Most search', context),
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
                      label: translatedWord('Trim stars', context),
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
    });
  }

  Widget retryWidget(String errorMessage, BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) => Column(
        children: [
          Expanded(
            child: RetryWidget(
                text: errorMessage,
                onRetry: () async {
                  HomeCubit.getInstance(context).loadHomeLayout(context);
                }),
          ),
          TextButton(
            onPressed: () async {
              await AuthCubit.getInstance(context).logout();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: Text(
              'Logout',
              style: TextStyle(fontSize: constants.defaultFontSize(deviceInfo)),
            ),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.red)),
          )
        ],
      ),
    );
  }

  Container buildMainListOffers(DeviceInfo deviceInfo) {
    return Container(
      height: deviceInfo.orientation == Orientation.portrait
          ? deviceInfo.localHeight / 3
          : deviceInfo.localHeight / 2,
      child: ResponsiveWidget(
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
