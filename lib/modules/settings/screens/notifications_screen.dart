import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: InfoWidget(
        responsiveWidget: (context, deviceInfo) => ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                height: deviceInfo.localHeight /
                    (deviceInfo.orientation == Orientation.portrait ? 5 : 3),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.all(10.0),
                  elevation: 6,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Reservation has been cancelled',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: deviceInfo.localWidth * 0.045),
                          ),
                        ),
                        IconButton(
                          color: Colors.red,
                          iconSize: deviceInfo.localWidth * 0.07,
                          icon: Icon(
                            Icons.delete_outline_outlined,
                          ),
                          onPressed: () {},
                        )
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
