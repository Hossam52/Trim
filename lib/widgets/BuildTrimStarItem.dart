import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class TrimStarItem extends StatelessWidget {
  const TrimStarItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        print(deviceInfo.type);
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
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
                      BuildStars(stars: 5, width: deviceInfo.localWidth / 1.8),
                      SizedBox(
                        height: 3,
                      ),
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                            child: Text(
                              'واحد من افضل الصالونات من حيث العناية والنظافة',
                              style:
                                  TextStyle(fontSize: getFontSize(deviceInfo)),
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
}
