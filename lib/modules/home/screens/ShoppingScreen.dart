import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Category.dart';
import 'package:trim/modules/home/screens/CategoryProductsScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildSearchWidget.dart';

class ShoppingScreen extends StatefulWidget {
  static final routeName = 'shoppingScreen';
  final void Function(int categoryIndex) setCategoryIndex;

  const ShoppingScreen({Key key, this.setCategoryIndex}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  bool swapWidget = false;
  int categoryIndex;

  @override
  void dispose() {
    print('Dispose shopping screen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        //  swapWidget
        //     ? CategoryProductsScreen(
        //         //categoryId: categoryId,
        //         categoryIndex: categoryIndex,
        //       )
        //     :
        Scaffold(
      body: SafeArea(
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
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                swapWidget = true;
                                categoryIndex = index;
                                widget.setCategoryIndex(index);
                                // dispose();
                              });
                            },
                            child: BuildCategoryItem(
                              category: categories[index],
                              deviceInfo: deviceInfo,
                            ),
                          ),
                          itemCount: categories.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  childAspectRatio:
                                      deviceInfo.type == deviceType.mobile
                                          ? 0.78
                                          : 1.4,
                                  mainAxisSpacing: 10),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildCategoryItem extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final Category category;

  const BuildCategoryItem({this.deviceInfo, this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: CircleAvatar(
            child: Image.asset(
              'assets/icons/${category.imageName}.png',
              fit: BoxFit.cover,
            ),
            radius: deviceInfo.type == deviceType.mobile
                ? deviceInfo.orientation == Orientation.portrait
                    ? 50
                    : 55
                : deviceInfo.orientation == Orientation.portrait
                    ? 55
                    : 65,
            backgroundColor: Colors.cyanAccent[100],
          ),
        ),
        Expanded(
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: deviceInfo.type == deviceType.mobile &&
                        deviceInfo.screenWidth >= 530
                    ? getFontSize(deviceInfo) + 4
                    : getFontSize(deviceInfo)),
          ),
        ),
      ],
    );
  }
}
