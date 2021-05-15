import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonServices extends StatelessWidget {
  final Widget child;
  final DeviceInfo deviceInfo;
  final List<SalonService> services;

  SalonServices({Key key, this.child, this.deviceInfo, @required this.services})
      : super(key: key);

  double fontSize;

  Widget serviceDiscription(SalonService service) {
    fontSize = getFontSizeVersion2(deviceInfo);
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

  List<Widget> allServices(BuildContext context) {
    final List<Widget> returnedServices = [];
    fontSize = getFontSizeVersion2(deviceInfo);
    final ktextStyle =
        TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold);

    for (int i = 0; i < services.length; i++)
      returnedServices.add(
        ListTile(
          onTap: () {
            SalonsCubit.getInstance(context)
                .toggelSelectedService(services[i].id);
          },
          title: Text(
            getTranslatedName(services[i]),
            style: ktextStyle,
          ),
          subtitle: serviceDiscription(
            services[i],
          ),
          trailing: Text(
            services[i].price.toString(),
            style: ktextStyle,
          ),
          leading: Checkbox(
            onChanged: (bool value) {
              SalonsCubit.getInstance(context)
                  .toggelSelectedService(services[i].id);
              print(SalonsCubit.getInstance(context).totalPrice);
            },
            value: services[i].selected,
          ),
        ),
      );
    print(returnedServices.length);
    return returnedServices;
  }

  @override
  Widget build(BuildContext context) {
    final salonServicesWidget = allServices(context);
    return Card(
      elevation: 10,
      child: Conditional.single(
        context: context,
        conditionBuilder: (_) => salonServicesWidget.isNotEmpty,
        widgetBuilder: (_) => foundServices(salonServicesWidget),
        fallbackBuilder: (_) => noServicesContainer(),
      ),
    );
  }

  Column foundServices(List<Widget> salonServicesWidget) {
    return Column(
      children: [
        ...salonServicesWidget,
        if (child != null) child,
      ],
    );
  }

  Container noServicesContainer() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Text(
        "No Services is added yet!.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
