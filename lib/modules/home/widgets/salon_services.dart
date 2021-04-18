import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/salon_service.dart';

class SalonServices extends StatefulWidget {
  final Widget child;

  const SalonServices({Key key, this.child}) : super(key: key);
  @override
  _SalonServicesState createState() => _SalonServicesState();
}

class _SalonServicesState extends State<SalonServices> {
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
        style: TextStyle(color: Colors.blue),
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
          title: Text(services[i].serviceName),
          subtitle: serviceDiscription(services[i]),
          trailing: Text(services[i].price.toString()),
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
