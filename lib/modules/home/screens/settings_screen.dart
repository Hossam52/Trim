import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/screens/ReservationsScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/auth/screens/personal_detail_screen.dart';
import 'package:trim/modules/home/screens/favourties_screen.dart';
import 'package:trim/modules/settings/screens/coupons_screen.dart';
import 'package:trim/modules/settings/screens/customer_serviceScreen.dart';
import 'package:trim/modules/settings/screens/notifications_screen.dart';
import 'package:trim/modules/settings/screens/wallet_screen.dart';

class SettingsScreen extends StatelessWidget {
  static final String routeName = 'settings';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BuildItemSetting(
              imagename: 'calendar',
              label: 'حجوازتي',
              function: () {
                Navigator.pushNamed(context, ReservationsScreen.routeName);
              },
            ),
            BuildItemSetting(
              imagename: 'bell',
              label: 'الأشعارات',
              function: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              },
            ),
            BuildItemSetting(
              imagename: 'user',
              label: 'الملف الشخصي',
              function: () {
                Navigator.pushNamed(context, PersonDetailScreen.routeName);
              },
            ),
            BuildItemSetting(
              imagename: 'wallet',
              label: 'محفظتي',
              function: () {
                Navigator.pushNamed(context, WalletScreen.routeName);
              },
            ),
            BuildItemSetting(
              imagename: 'coupon',
              label: 'الكوبونات',
              function: () {
                Navigator.pushNamed(context, CouponsScreen.routeName);
              },
            ),
            BuildItemSetting(
              imagename: 'favourite',
              label: 'مفضلتي',
              function: () {
                Navigator.pushNamed(context, FavouritesScreen.routeName);
              },
            ),
            BuildItemSetting(
              imagename: 'support',
              label: 'خدمة العملاء',
              function: () {
                Navigator.pushNamed(context, CustomerServiceScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BuildItemSetting extends StatelessWidget {
  final String label;
  final Function function;
  final String imagename;
  BuildItemSetting({this.function, this.imagename, this.label});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        return ListTile(
          onTap: function,
          leading: Image.asset('assets/icons/$imagename.png'),
          title: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: getFontSize(deviceInfo)),
          ),
        );
      },
    );
  }
}
