import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/cubit/app_states.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/modules/settings/cubits/settings_cubit.dart';
import 'package:trim/modules/settings/cubits/settings_states.dart';
import 'package:trim/modules/settings/widgets/setting_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/auth/screens/personal_detail_screen.dart';
import 'package:trim/modules/settings/screens/favourties_screen.dart';
import 'package:trim/modules/settings/screens/coupons_screen.dart';
import 'package:trim/modules/settings/screens/customer_serviceScreen.dart';
import 'package:trim/modules/settings/screens/notifications_screen.dart';
import 'package:trim/modules/settings/screens/wallet_screen.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class SettingsScreen extends StatefulWidget {
  static final String routeName = 'settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // SettingCubit.getInstance(context).loadPersonalData();
  }

  @override
  void dispose() async {
    print('Dispose settings');
    // SettingCubit.getInstance(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: BlocBuilder<SettingCubit, SettingsStatates>(
          builder: (_, state) {
            if (state is LoadingPersonalDataState)
              return Center(child: CircularProgressIndicator());
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, PersonDetailScreen.routeName);
                      },
                      child: buildPersonWidget(context)),
                ),
                Divider(),
                SettingItem(
                  imagename: 'calendar',
                  //label: 'حجوازتي',
                  label: getWord("my reservations", context),
                  function: () {
                    Navigator.pushNamed(context, ReservationsScreen.routeName);
                  },
                ),
                SettingItem(
                  imagename: 'bell',
                  // label: 'الأشعارات',
                  label: getWord("notifications", context),
                  function: () => SettingCubit.getInstance(context)
                      .navigateToNotificationsScreen(context),
                ),
                SettingItem(
                  imagename: 'user',
                  //label: 'الملف الشخصي',
                  label: getWord("personal profile", context),
                  function: () {
                    Navigator.pushNamed(context, PersonDetailScreen.routeName);
                  },
                ),
                SettingItem(
                  imagename: 'favourite',
                  // label: 'مفضلتي',
                  label: getWord("my favorites", context),
                  function: () => HomeCubit.getInstance(context)
                      .navigateToFavoriets(context),
                ),
                SettingItem(
                  imagename: 'support',
                  // label: 'خدمة العملاء',
                  label: getWord("support", context),
                  function: () {
                    if (SettingCubit.getInstance(context).emails.isEmpty ||
                        SettingCubit.getInstance(context).phones.isEmpty)
                      SettingCubit.getInstance(context).loadContacts();
                    Navigator.pushNamed(
                        context, CustomerServiceScreen.routeName);
                  },
                ),
                InfoWidget(
                  responsiveWidget: (context, deviceInfo) {
                    return ListTile(
                      onTap: () async {
                        final logout = await confirmLogout(context);
                        if (logout) {
                          await SettingCubit.getInstance(context)
                              .logoutUser(context);

                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        }
                      },
                      leading: Icon(Icons.logout, color: Colors.blue),
                      title: Text(
                        getWord("log out", context),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getFontSizeVersion2(deviceInfo)),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildPersonWidget(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (_, state) => InfoWidget(
        responsiveWidget: (_, deviceInfo) => Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: deviceInfo.screenHeight * 0.2,
                width: deviceInfo.screenWidth * 0.4,
                child:
                    TrimCachedImage(src: AppCubit.getInstance(context).image),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FittedBox(
                        child: Text(AppCubit.getInstance(context).name,
                            style: TextStyle(
                                fontSize: getFontSizeVersion2(deviceInfo),
                                fontWeight: FontWeight.bold))),
                    FittedBox(
                      child: Text(AppCubit.getInstance(context).email,
                          style: TextStyle(
                              fontSize: getFontSizeVersion2(deviceInfo),
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
