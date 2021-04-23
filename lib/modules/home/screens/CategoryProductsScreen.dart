import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Category.dart';
import 'package:trim/modules/home/models/Product.dart';
import 'package:trim/modules/home/screens/BadgeScreen.dart';
import 'package:trim/modules/home/screens/ShoppingScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildRawMaterialButton.dart';
import 'package:trim/widgets/BuildSearchWidget.dart';

class CategoryProductsScreen extends StatefulWidget {
  static final routeName = 'categoryProductScreen';
  final int categoryIndex;
  final void Function() backToCategories;
  CategoryProductsScreen({this.categoryIndex, this.backToCategories});

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool swapWidget = false;

  @override
  void dispose() {
    super.dispose();
    print('Dispose categoryProductScreen');
  }

  List<Prodcut> filteredProducts = [];
  @override
  void initState() {
    super.initState();
    filteredProducts = products
        .where((product) =>
            product.categoryId == categories[widget.categoryIndex].id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return
        // swapWidget
        //     ? ShoppingScreen()
        //     :
        Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[800],
          leading: BackButton(
            onPressed: () {
              setState(() {
                swapWidget = true;
                widget.backToCategories();
                // dispose();
              });
            },
          ),
          title: Text('${categories[widget.categoryIndex].name}')),
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
                          itemCount: filteredProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.47,
                          ),
                          itemBuilder: (context, index) {
                            return BuildProductItem(
                              deviceInfo: deviceInfo,
                              prodcut: filteredProducts[index],
                            );
                          }),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Probelm
                      Navigator.pushNamed(context, BadgeScrren.routeName);
                    },
                    child: Text('Enter To Products'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class BuildProductItem extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final Prodcut prodcut;
  BuildProductItem({this.deviceInfo, this.prodcut});

  @override
  _BuildProductItemState createState() => _BuildProductItemState();
}

class _BuildProductItemState extends State<BuildProductItem> {
  int quantity = 0;
  double fontSize = 0;
  @override
  Widget build(BuildContext context) {
    fontSize = getFontSizeVersion2(widget.deviceInfo);
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
                'assets/images/${widget.prodcut.productImage}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              widget.prodcut.productName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: Text(widget.prodcut.productPrice.toString(),
                  style: TextStyle(fontSize: fontSize, color: Colors.green))),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BuildRawMaterialButton(
                  icon: Icons.add,
                  pressed: quantity == 10
                      ? null
                      : () {
                          if (quantity != 10)
                            setState(() {
                              quantity++;
                            });
                        },
                  deviceInfo: widget.deviceInfo,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: fontSize),
                ),
                BuildRawMaterialButton(
                  icon: Icons.remove,
                  pressed: quantity == 0
                      ? null
                      : () {
                          if (quantity != 0)
                            setState(() {
                              quantity--;
                            });
                        },
                  deviceInfo: widget.deviceInfo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
