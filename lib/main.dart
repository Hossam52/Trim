import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';

import './constants/app_constant.dart';
import './config/routes/routes_builder.dart';

main() => runApp(DevicePreview(builder: (_) => MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(button: TextStyle(fontSize: defaultFontSize))),
        // home: SplashScreen(alpha: 100, color: Color(0xff2B73A8)),
        builder: DevicePreview.appBuilder,
        home: HomeScreen()
        // ReserveScreen(
        //   selectDateWidget: SelectDateSliver(),
        //   availableDatesWidget: AvailableTimes(
        //     updateSelectedIndex: (index) {},
        //     availableDates: _availableTimes,
        //   ),
        //   servicesWidget: SalonServices(),
        //   offersWidget: SalonOffers(),
        ,
        routes: routes);
  }
}

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              Align(
                                heightFactor: 1,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 40),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 45),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                            Text('Hello',
                                                style: TextStyle(fontSize: 22)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Align(
                                    heightFactor: 1.0,
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ));
            },
            child: Text('Press me'),
          ),
        ));
  }
}
