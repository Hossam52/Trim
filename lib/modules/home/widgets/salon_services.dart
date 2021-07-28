import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/widgets/salon_service_item.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonServices extends StatelessWidget {
  final Widget bottomWidget; //For any widget under the services card
  final DeviceInfo deviceInfo;
  final List<SalonService> services; //Services to be rendered
  final void Function(int) onItemToggled; //When service tapped

  SalonServices(
      {Key key,
      this.bottomWidget,
      this.deviceInfo,
      @required this.services,
      @required this.onItemToggled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Conditional.single(
        context: context,
        conditionBuilder: (_) => services.isNotEmpty,
        widgetBuilder: (_) => foundServices(),
        fallbackBuilder: (_) => noServicesContainer(context),
      ),
    );
  }

  Column foundServices() {
    return Column(
      children: [
        ...services.map((service) =>
            SalonServiceItem(service: service, onItemToggled: onItemToggled)),
        if (bottomWidget != null) bottomWidget,
      ],
    );
  }

  Container noServicesContainer(BuildContext context) {
    double fontSize = defaultFontSize(deviceInfo);

    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Text(
        translatedWord("No Services is added yet", context),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
