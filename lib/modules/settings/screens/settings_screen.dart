import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/modules/settings/widgets/setting_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/auth/screens/personal_detail_screen.dart';
import 'package:trim/modules/settings/screens/favourties_screen.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PersonDetailScreen.routeName);
                  },
                  child: buildPersonWidget()),
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
              function: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              },
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
              imagename: 'wallet',
              // label: 'محفظتي',

              label: getWord("my wallet", context),
              function: () {
                Navigator.pushNamed(context, WalletScreen.routeName);
              },
            ),
            SettingItem(
              imagename: 'coupon',
              // label: 'الكوبونات',
              label: getWord("copouns", context),
              function: () {
                Navigator.pushNamed(context, CouponsScreen.routeName);
              },
            ),
            SettingItem(
              imagename: 'favourite',
              // label: 'مفضلتي',
              label: getWord("my favorites", context),
              function: () {
                Navigator.pushNamed(context, FavouritesScreen.routeName);
              },
            ),
            SettingItem(
              imagename: 'support',
              // label: 'خدمة العملاء',
              label: getWord("support", context),
              function: () {
                Navigator.pushNamed(context, CustomerServiceScreen.routeName);
              },
            ),
            InfoWidget(
              responsiveWidget: (context, deviceInfo) {
                return ListTile(
                  onTap: () {},
                  leading: Icon(Icons.logout, color: Colors.blue),
                  title: Text(
                    // 'تسجيل الخروج',
                    getWord("log out", context),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getFontSizeVersion2(deviceInfo)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildPersonWidget() {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Row(
        children: [
          Container(
            height: deviceInfo.screenHeight * 0.2,
            width: deviceInfo.screenWidth * 0.4,
            //width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage('assets/images/barber.jpg'),
                    fit: BoxFit.fill)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FittedBox(
                      child: Text('Hossam Hassan',
                          style: TextStyle(
                              fontSize: getFontSizeVersion2(deviceInfo),
                              fontWeight: FontWeight.bold))),
                  FittedBox(
                    child: Text('hossam.fcis@gmail.com',
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
    );
  }
}
