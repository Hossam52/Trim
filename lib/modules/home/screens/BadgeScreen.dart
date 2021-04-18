import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Product.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/widgets/BuildRawMaterialButton.dart';
import 'package:trim/widgets/default_button.dart';

class BadgeScrren extends StatelessWidget {
  static String routeName = 'BadgeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: kPadding,
              child: InfoWidget(
                responsiveWidget: (context, deviceInfo) {
                  return Column(
                    children: [
                      Expanded(
                        flex: deviceInfo.orientation == Orientation.portrait
                            ? 9
                            : 7,
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return ProductItem(
                                index: index, deviceInfo: deviceInfo);
                          },
                        ),
                      ),
                      Expanded(
                        child: buildConfirmButton(deviceInfo),
                      )
                    ],
                  );
                },
              ),
            ),
            buildBackButton(),
          ],
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return Container(
      width: double.infinity,
      color: Colors.grey.withAlpha(150),
      child: Align(
        heightFactor: 1,
        alignment: Alignment.centerLeft,
        child: BackButton(color: Colors.black),
      ),
    );
  }

  Widget buildConfirmButton(DeviceInfo deviceInfo) {
    return Container(
      margin: deviceInfo.orientation == Orientation.portrait
          ? EdgeInsets.only(top: 15)
          : null,
      width: deviceInfo.localWidth / 1.3,
      child: DefaultButton(
        onPressed: () {},
        text: 'Confirm order',
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final int index;
  final DeviceInfo deviceInfo;

  const ProductItem({Key key, @required this.index, @required this.deviceInfo})
      : super(key: key);
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int quantity = 0;
  int totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(products[widget.index].productId),
      background: Center(
        child: Text(
          'Delete This Item',
          style: TextStyle(
              fontSize: getFontSize(widget.deviceInfo), color: Colors.red),
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
        height: widget.deviceInfo.orientation == Orientation.portrait
            ? widget.deviceInfo.localHeight / 4
            : widget.deviceInfo.localHeight / 2.4,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: Row(
            children: [
              Expanded(flex: 2, child: buildProductImage(widget.deviceInfo)),
              Expanded(flex: 3, child: buildProductDetails(widget.deviceInfo)),
              Expanded(
                child: buildTrashIcon(widget.deviceInfo),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductDetails(DeviceInfo deviceInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: buildProductName(deviceInfo)),
        Expanded(child: buildTotalPrice(deviceInfo)),
        Expanded(child: buildActionButtons(deviceInfo)),
      ],
    );
  }

  Widget buildTrashIcon(DeviceInfo deviceInfo) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: IconButton(
        icon: Icon(
          Icons.delete_outline_sharp,
          color: Colors.redAccent,
          size: deviceInfo.type == deviceType.mobile ? 40 : 55,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget buildActionButtons(DeviceInfo deviceInfo) {
    return Row(
      children: [
        BuildRawMaterialButton(
          icon: Icons.add,
          pressed: quantity == 10
              ? null
              : () {
                  setState(() {
                    quantity++;
                    totalPrice += products[widget.index].productPrice.round();
                  });
                },
          deviceInfo: deviceInfo,
        ),
        Text(
          '$quantity',
          style: TextStyle(fontSize: getFontSize(deviceInfo) - 5),
        ),
        BuildRawMaterialButton(
          icon: Icons.remove,
          pressed: quantity == 0
              ? null
              : () {
                  setState(() {
                    quantity--;
                    totalPrice -= products[widget.index].productPrice.round();
                  });
                },
          deviceInfo: deviceInfo,
        ),
      ],
    );
  }

  Widget buildTotalPrice(DeviceInfo deviceInfo) {
    return FittedBox(
      child: Text(
        'Total price: $totalPrice',
        style: TextStyle(
            fontSize: getFontSize(deviceInfo) - 6, color: Colors.green),
      ),
    );
  }

  Widget buildProductName(DeviceInfo deviceInfo) {
    return FittedBox(
      child: Text(
        'Product name',
        style: TextStyle(
            fontSize: getFontSize(deviceInfo) - 6, color: Colors.lightBlue),
      ),
    );
  }

  Widget buildProductImage(DeviceInfo deviceInfo) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        'assets/images/shampoo1.jpg',
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
