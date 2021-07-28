import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/screens/login_screen.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/cubit/app_states.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/general_widgets/trim_cached_image.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/modules/settings/cubits/settings_cubit.dart';
import 'package:trim/modules/settings/cubits/settings_states.dart';
import 'package:trim/modules/settings/widgets/setting_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import 'package:trim/modules/auth/screens/personal_detail_screen.dart';
import 'package:trim/modules/settings/screens/customer_serviceScreen.dart';
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
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingCubit(),
      child: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: BlocBuilder<SettingCubit, SettingsStatates>(
              builder: (_, state) {
                if (state is LoadingPersonalDataState)
                  return TrimLoadingWidget();
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
                      iconPath: calendarIcon,
                      label: translatedWord("my reservations", context),
                      function: () async {
                        Navigator.of(context)
                            .pushNamed(ReservationsScreen.routeName);
                      },
                    ),
                    SettingItem(
                      iconPath: bellIcon,
                      label: translatedWord("notifications", context),
                      function: () => SettingCubit.getInstance(context)
                          .navigateToNotificationsScreen(context),
                    ),
                    SettingItem(
                      iconPath: userIcon,
                      label: translatedWord("personal profile", context),
                      function: () {
                        Navigator.pushNamed(
                            context, PersonDetailScreen.routeName);
                      },
                    ),
                    SettingItem(
                      iconPath: favouriteIcon,
                      label: translatedWord("my favorites", context),
                      function: () => HomeCubit.getInstance(context)
                          .navigateToFavoriets(context),
                    ),
                    SettingItem(
                      iconPath: supportIcon,
                      label: translatedWord("support", context),
                      function: () {
                        if (SettingCubit.getInstance(context).emails.isEmpty ||
                            SettingCubit.getInstance(context).phones.isEmpty)
                          SettingCubit.getInstance(context).loadContacts();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                      value: SettingCubit.getInstance(context),
                                      child: CustomerServiceScreen(),
                                    )));
                      },
                    ),
                    ResponsiveWidget(
                      responsiveWidget: (context, deviceInfo) {
                        return ListTile(
                          onTap: () async {
                            final logout = await confirmLogout(context);
                            if (logout != null && logout) {
                              await SettingCubit.getInstance(context)
                                  .logoutUser(context);
                              AuthCubit.getInstance(context).logout();
                              await loadingLogoutDialog(context);
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            }
                          },
                          leading: Icon(Icons.logout, color: Colors.red),
                          title: Text(
                            translatedWord("log out", context),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                fontSize: defaultFontSize(deviceInfo)),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPersonWidget(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (_, state) => ResponsiveWidget(
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
                                fontSize: defaultFontSize(deviceInfo),
                                fontWeight: FontWeight.bold))),
                    FittedBox(
                      child: Text(AppCubit.getInstance(context).email,
                          style: TextStyle(
                              fontSize: defaultFontSize(deviceInfo),
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
