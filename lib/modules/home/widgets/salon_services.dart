import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/screens/time_selection_screen.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonServices extends StatefulWidget {
  final Widget child;
  final DeviceInfo deviceInfo;

  const SalonServices({Key key, this.child, this.deviceInfo}) : super(key: key);
  @override
  _SalonServicesState createState() => _SalonServicesState();
}

class _SalonServicesState extends State<SalonServices> {
  bool isPortrait;
  double fontSize;
  TextStyle kTextStyle;
  final List<SalonService> services = [
    SalonService(
      serviceName: 'Hair cut',
      price: 200,
    ),
    SalonService(
      serviceName: 'Badikir',
      discription: 'hand and foot',
      price: 350,
    ),
    SalonService(
      serviceName: 'Manikir',
      price: 150,
    ),
    SalonService(
      serviceName: 'Sab8a',
      price: 500,
    ),
  ];

  Widget serviceDiscription(SalonService service) {
    if (service.discription == null)
      return null;
    else
      return Text(
        service.discription,
        style: kTextStyle.copyWith(
          color: Colors.blue,
          fontSize: fontSize - 3,
        ),
      );
  }

  List<Widget> allServices() {
    final List<Widget> returnedServices = [];

    for (int i = 0; i < services.length; i++)
      returnedServices.add(
        ListTile(
          onTap: () {
            setState(() {
              services[i].selected = !services[i].selected;
            });
          },
          title: Text(
            services[i].serviceName,
            style: kTextStyle,
          ),
          subtitle: serviceDiscription(
            services[i],
          ),
          trailing: Text(
            services[i].price.toString(),
            style: kTextStyle,
          ),
          leading: Checkbox(
            onChanged: (bool value) {
              setState(() {
                services[i].selected = value;
              });
            },
            value: services[i].selected,
          ),
        ),
      );
    return returnedServices;
  }

  @override
  void initState() {
    isPortrait = widget.deviceInfo.orientation == Orientation.portrait;
    fontSize = isPortrait
        ? widget.deviceInfo.localWidth *
            (widget.deviceInfo.type == deviceType.mobile ? 0.035 : 0.062)
        : widget.deviceInfo.type == deviceType.mobile
            ? widget.deviceInfo.localWidth * 0.044
            : widget.deviceInfo.localWidth * 0.057;
    kTextStyle = TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Column(
          children: [
            ...allServices(),
            if (widget.child != null) widget.child,
          ],
        ));
  }
}
