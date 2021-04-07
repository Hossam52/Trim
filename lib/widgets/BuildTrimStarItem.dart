import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

Widget buildTrimStarItem({bool starItemScreen}) {
  return InfoWidget(
    responsiveWidget: (context, deviceInfo) {
      print(deviceInfo.type);
      return Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/1.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'احمد محمد',
                      style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: getFontSize(deviceInfo)),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      height: deviceInfo.orientation == Orientation.portrait
                          ? deviceInfo.localHeight / 6
                          : deviceInfo.localHeight / 5,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          padding: EdgeInsets.zero,
                          itemCount: 5,
                          itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(2),
                                child: Image.asset(
                                  'assets/icons/star.png',
                                  fit: BoxFit.fill,
                                ),
                              )),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    starItemScreen
                        ? Text(
                            ' 20 رأي',
                            style: TextStyle(
                              fontSize: getFontSize(deviceInfo),
                            ),
                            textDirection: TextDirection.rtl,
                          )
                        : Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Text(
                                  'واحد من افضل الصالونات من حيث العناية والنظافة',
                                  style: TextStyle(
                                      fontSize: getFontSize(deviceInfo)),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
