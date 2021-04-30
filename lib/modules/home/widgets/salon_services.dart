import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonServices extends StatefulWidget {
  final Widget child;
  final DeviceInfo deviceInfo;
  final List<SalonService> services;

  const SalonServices(
      {Key key, this.child, this.deviceInfo, @required this.services})
      : super(key: key);
  @override
  _SalonServicesState createState() => _SalonServicesState();
}

class _SalonServicesState extends State<SalonServices> {
  double fontSize;

  Widget serviceDiscription(SalonService service) {
    fontSize = getFontSizeVersion2(widget.deviceInfo);
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

  List<Widget> allServices() {
    final List<Widget> returnedServices = [];
    fontSize = getFontSizeVersion2(widget.deviceInfo);
    final ktextStyle =
        TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold);
    for (int i = 0; i < widget.services.length; i++)
      if (widget.services[i].titleEn != null &&
          widget.services[i].titleAr != null &&
          widget.services[i].price != null)
        returnedServices.add(
          ListTile(
            onTap: () {
              setState(() {
                widget.services[i].selected = !widget.services[i].selected;
              });
            },
            title: Text(
              widget.services[i].titleEn == null
                  ? widget.services[i].titleAr
                  : widget.services[i].titleEn,
              style: ktextStyle,
            ),
            subtitle: serviceDiscription(
              widget.services[i],
            ),
            trailing: Text(
              widget.services[i].price.toString(),
              style: ktextStyle,
            ),
            leading: Checkbox(
              onChanged: (bool value) {
                setState(() {
                  widget.services[i].selected = value;
                });
              },
              value: widget.services[i].selected,
            ),
          ),
        );

    return returnedServices;
  }

  @override
  Widget build(BuildContext context) {
    final salonServicesWidget = allServices();
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
        if (widget.child != null) widget.child,
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
