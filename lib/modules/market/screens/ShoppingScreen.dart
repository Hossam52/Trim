import 'package:flutter/material.dart';

import 'package:trim/modules/market/models/Category.dart';
import 'package:trim/modules/market/widgets/cart.dart';
import 'package:trim/modules/market/widgets/category_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/BuildSearchWidget.dart';

class ShoppingScreen extends StatefulWidget {
  static final routeName = 'shoppingScreen';
  final void Function(int categoryIndex) setCategoryIndex;

  const ShoppingScreen({Key key, this.setCategoryIndex}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  void dispose() {
    print('Dispose shopping screen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: buildHeader(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: buildCategories(deviceInfo),
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

  GridView buildCategories(DeviceInfo deviceInfo) {
    return GridView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => widget.setCategoryIndex(index),
        child:
            CategoryItem(category: categories[index], deviceInfo: deviceInfo),
      ),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          childAspectRatio: deviceInfo.type == deviceType.mobile ? 0.78 : 1.4,
          mainAxisSpacing: 10),
    );
  }

  Row buildHeader() {
    return Row(
      children: [
        Cart(),
        Expanded(
          child: BuildSearchWidget(
            pressed: () {},
          ),
        ),
      ],
    );
  }
}
