import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Product.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/widgets/BuildRawMaterialButton.dart';

class BadgeScrren extends StatelessWidget {
  static String routeName = 'BadgeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: kPadding,
            child: InfoWidget(responsiveWidget: (context, deviceInfo) {
              return Column(children: [
                Expanded(
                  flex: deviceInfo.orientation == Orientation.portrait ? 9 : 7,
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(products[index].productId),
                          background: Center(
                            child: Text(
                              'Delete This Item',
                              style: TextStyle(
                                  fontSize: getFontSize(deviceInfo),
                                  color: Colors.red),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (dismiss) {
                            print(dismiss);
                          },
                          confirmDismiss: (dissmiss) async {
                            print('Sure');
                            return true;
                          },
                          child: Container(
                            height:
                                deviceInfo.orientation == Orientation.portrait
                                    ? deviceInfo.localHeight / 4
                                    : deviceInfo.localHeight / 2.4,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/images/shampoo1.jpg',
                                        height: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: FittedBox(
                                            child: Text(
                                              'اسم المنتج',
                                              style: TextStyle(
                                                  fontSize:
                                                      getFontSize(deviceInfo) -
                                                          6,
                                                  color: Colors.lightBlue),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            child: Text(
                                              'اجمالي السعر : 400',
                                              style: TextStyle(
                                                  fontSize:
                                                      getFontSize(deviceInfo) -
                                                          6,
                                                  color: Colors.green),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              BuildRawMaterialButton(
                                                icon: Icons.add,
                                                pressed: () {},
                                                deviceInfo: deviceInfo,
                                              ),
                                              Text(
                                                '0',
                                                style: TextStyle(
                                                    fontSize: getFontSize(
                                                            deviceInfo) -
                                                        5),
                                              ),
                                              BuildRawMaterialButton(
                                                icon: Icons.remove,
                                                pressed: () {},
                                                deviceInfo: deviceInfo,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete_outline_sharp,
                                          color: Colors.redAccent,
                                          size: deviceInfo.type ==
                                                  deviceType.mobile
                                              ? 40
                                              : 55,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: Container(
                    margin: deviceInfo.orientation == Orientation.portrait
                        ? EdgeInsets.only(top: 15)
                        : null,
                    width: deviceInfo.localWidth / 1.3,
                    child: TextButton(
                      onPressed: () {},
                      child: FittedBox(
                        child: Text(
                          'تأكيد الطلب',
                        ),
                      ),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          TextStyle(
                            fontSize: getFontSize(deviceInfo),
                          ),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        alignment: Alignment.center,
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            deviceInfo.type == deviceType.mobile ? 25 : 35,
                          ),
                        )),
                      ),
                    ),
                  ),
                )
              ]);
            })),
      ),
    );
  }
}
