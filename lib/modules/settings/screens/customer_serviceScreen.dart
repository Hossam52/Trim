import 'package:flutter/material.dart';
import 'package:trim/modules/settings/cubits/settings_cubit.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class CustomerServiceScreen extends StatelessWidget {
  static const routeName = '/customer-service';
  // final email = 'hossam.fcis@gmail.com';
  // final phones = ['01115425561', '0248581898', '12345676', '1111111111'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer service', style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/customer-services.png'),
            Container(
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.grey)),
                child: _buildContactInformation(context))
          ],
        ),
      ),
    );
  }

  Widget _buildContactInformation(BuildContext context) {
    final phones = SettingCubit.getInstance(context).phones;
    final emails = SettingCubit.getInstance(context).emails;
    return InfoWidget(responsiveWidget: (_, deviceInfo) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text('Customer service numbers:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: phones.map((phone) => Text(phone.phone)).toList(),
              )
            ],
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Text('Eamil: ',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: emails.map((e) => Text(e.email)).toList(),
              )
            ],
          ),
        ],
      );
    });
  }
}
