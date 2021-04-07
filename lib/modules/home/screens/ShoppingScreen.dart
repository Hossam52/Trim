import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/screens/CategoryProductsScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/widgets/BuildSearchWidget.dart';

class ShoppingScreen extends StatelessWidget {
  static final routeName = 'shoppingScreen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InfoWidget(
          responsiveWidget: (context, deviceInfo) {
            print(deviceInfo.type);
            return Container(
              height: deviceInfo.localHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        BuildSearchWidget(
                          pressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GridView.builder(
                          itemCount: 9,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  childAspectRatio:
                                      deviceInfo.type == deviceType.mobile
                                          ? 0.85
                                          : 1.4,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, CategoryProductsScreen.routeName);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/icons/hari-dresser.png'),
                                    radius: deviceInfo.type == deviceType.mobile
                                        ? deviceInfo.orientation ==
                                                Orientation.portrait
                                            ? 35
                                            : 50
                                        : deviceInfo.orientation ==
                                                Orientation.portrait
                                            ? 50
                                            : 60,
                                    backgroundColor: Colors.cyanAccent[200],
                                  ),
                                  Text(
                                    'Category',
                                    style: TextStyle(
                                        fontSize: getFontSize(deviceInfo)),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
