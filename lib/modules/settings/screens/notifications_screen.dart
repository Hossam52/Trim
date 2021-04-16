import 'package:flutter/material.dart';

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
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.all(10.0),
                elevation: 6,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: Text('Reservation has been cancelled',
                      style: TextStyle(color: Colors.grey)),
                  trailing: InkWell(
                    onTap: () {
                      print('notification tapped');
                    },
                    child: ImageIcon(AssetImage('assets/icons/trash.png'),
                        size: 40, color: Colors.red),
                  ),
                ),
              );
            }));
  }
}
