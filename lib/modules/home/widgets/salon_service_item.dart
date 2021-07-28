import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonServiceItem extends StatelessWidget {
  final SalonService service;
  final void Function(int serviceId) onItemToggled;
  const SalonServiceItem(
      {Key key, @required this.service, @required this.onItemToggled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) => ListTile(
        onTap: () {
          onItemToggled(service.id);
        },
        title: Text(
          getTranslatedName(service),
          style: TextStyle(
              fontSize: defaultFontSize(deviceInfo),
              fontWeight: FontWeight.bold),
        ),
        subtitle: serviceDiscription(
          service,
          deviceInfo,
        ),
        trailing: Text(
          service.price.toString(),
          style: TextStyle(
              fontSize: defaultFontSize(deviceInfo),
              fontWeight: FontWeight.bold),
        ),
        leading: Checkbox(
          onChanged: (bool value) {
            onItemToggled(service.id);
          },
          value: service.selected,
        ),
      ),
    );
  }

  Widget serviceDiscription(SalonService service, DeviceInfo deviceInfo) {
    double fontSize = defaultFontSize(deviceInfo) * 0.65;
    if (service.descriptionEn == null && service.descriptionAr == null)
      return null;
    else
      return Text(
        service.descriptionEn == null
            ? service.descriptionAr
            : service.descriptionEn,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue),
      );
  }
}
