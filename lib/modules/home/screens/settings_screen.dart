import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/screens/ReservationsScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

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
              function: () {},
            ),
            BuildItemSetting(
              imagename: 'user',
              label: 'الملف الشخصي',
              function: () {},
            ),
            BuildItemSetting(
              imagename: 'wallet',
              label: 'محفظتي',
              function: () {},
            ),
            BuildItemSetting(
              imagename: 'coupon',
              label: 'الكوبونات',
              function: () {},
            ),
            BuildItemSetting(
              imagename: 'favourite',
              label: 'مفضلتي',
              function: () {},
            ),
            BuildItemSetting(
              imagename: 'support',
              label: 'خدمة العملاء',
              function: () {},
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
