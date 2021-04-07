import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildSearchWidget.dart';

class CategoryProductsScreen extends StatelessWidget {
  static final routeName = 'categoryProductScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InfoWidget(
            responsiveWidget: (context, deviceInfo) {
              return Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      BuildSearchWidget(
                        pressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.5,
                        ),
                        itemBuilder: (context, index) {
                          return BuildProductItem(deviceInfo);
                        }),
                  ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildProductItem extends StatelessWidget {
  final DeviceInfo deviceInfo;

  BuildProductItem(this.deviceInfo);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0, 2),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: Image.asset(
                'assets/images/person3.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
              child: Text(
            'name',
            style: TextStyle(
                fontSize: getFontSize(deviceInfo), fontWeight: FontWeight.bold),
          )),
          Expanded(
              child: Text('Price',
                  style: TextStyle(
                      fontSize: getFontSize(deviceInfo), color: Colors.green))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildRawMaterialButton(
                    icon: Icons.add,
                    pressed: () {},
                  ),
                  Text('0'),
                  BuildRawMaterialButton(
                    icon: Icons.remove,
                    pressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildRawMaterialButton extends StatelessWidget {
  final IconData icon;
  final Function pressed;
  BuildRawMaterialButton({this.icon, this.pressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: pressed,
        child: Icon(icon),
        shape: const CircleBorder(
            side: BorderSide(
          width: 1,
          color: Colors.black,
        )),
      ),
    );
  }
}
