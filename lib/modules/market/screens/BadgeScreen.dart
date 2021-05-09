import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/cubit/cart_states.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/payment/screens/confirm_order_screen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/BuildRawMaterialButton.dart';
import 'package:trim/general_widgets/default_button.dart';

class BadgeScrren extends StatelessWidget {
  static String routeName = 'BadgeScreen';
  GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: kPadding,
              child: InfoWidget(
                responsiveWidget: (context, deviceInfo) {
                  return BlocConsumer<CartBloc, CartStates>(
                      listener: (ctx, state) {
                    if (state is ErrorStateCartInBadge) {
                      print('Appear Here');
                      Fluttertoast.showToast(
                          msg: 'Please check your internet connecation2');
                    }
                  }, builder: (_, state) {
                    List<CartItem> cartItems =
                        BlocProvider.of<CartBloc>(context).getCartList();
                    return Column(
                      children: [
                        Expanded(
                          flex: deviceInfo.orientation == Orientation.portrait
                              ? 9
                              : 7,
                          child: ListView.builder(
                            itemCount:
                                BlocProvider.of<CartBloc>(context).items.length,
                            itemBuilder: (context, index) {
                              return ProductItem(
                                deviceInfo: deviceInfo,
                                cartItem: cartItems[index],
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: buildConfirmButton(deviceInfo, context),
                        )
                      ],
                    );
                  });
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

  Widget buildConfirmButton(DeviceInfo deviceInfo, BuildContext context) {
    return Container(
      margin: deviceInfo.orientation == Orientation.portrait
          ? EdgeInsets.only(top: 15)
          : null,
      width: deviceInfo.localWidth / 1.3,
      child: DefaultButton(
        onPressed: () async {
          if(BlocProvider.of<CartBloc>(context).items.length==0)
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('The cart is empty please enter items')));
                else
          Navigator.pushNamed(context, ConfirmOrderScreen.routeName);
          
        },
        text: 'Confirm order',
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final CartItem cartItem;
  final DeviceInfo deviceInfo;

  const ProductItem({@required this.cartItem, @required this.deviceInfo});
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  CartBloc cartBloc;
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.deviceInfo.orientation == Orientation.portrait
          ? widget.deviceInfo.localHeight / 4
          : widget.deviceInfo.localHeight / 2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        onPressed: () async {
          bool isDeleted = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Are you sure to remove item ?'),
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'undo',
              onPressed: () {
                isDeleted = false;
              },
            ),
          ));
          await Future.delayed(Duration(seconds: 3));
          if (isDeleted)
            cartBloc.add(DeleteItemEvent(
                id: widget.cartItem.id,
                rowId: widget.cartItem.rowId,
                screenId: '2'));
        },
      ),
    );
  }

  Widget buildActionButtons(DeviceInfo deviceInfo) {
     bool isEnabled =(widget.cartItem.quantity?? '0') == '10';
    return Row(
      children: [
        BuildRawMaterialButton(
          icon: Icons.add,
          pressed: isEnabled?null:() {
            cartBloc.add(
              AddingItemEvent(
                  cartItem: CartItem(
                    rowId: widget.cartItem.rowId,
                    id: widget.cartItem.id,
                    imageName: widget.cartItem.imageName,
                    nameAr: widget.cartItem.nameAr,
                    price: widget.cartItem.price,
                    nameEn: widget.cartItem.nameEn,
                    quantity: widget.cartItem.quantity,
                  ),
                  screenId: '2'),
            );
          },
          deviceInfo: deviceInfo,
        ),
        Text(
          '${widget.cartItem.quantity}',
          style: TextStyle(fontSize: getFontSizeVersion2(deviceInfo) - 5),
        ),
        BuildRawMaterialButton(
          icon: Icons.remove,
          pressed: widget.cartItem.quantity == '1'
              ? null
              : () {
                  cartBloc.add(
                      DecreaseEvent(id: widget.cartItem.id, screenId: '2'));
                },
          deviceInfo: deviceInfo,
        ),
      ],
    );
  }

  Widget buildTotalPrice(DeviceInfo deviceInfo) {
    return FittedBox(
      child: Text(
        'total price: ${double.parse(widget.cartItem.price) * double.parse(widget.cartItem.quantity)}',
        style: TextStyle(
            fontSize: getFontSizeVersion2(deviceInfo) - 13,
            color: Colors.green),
      ),
    );
  }

  Widget buildProductName(DeviceInfo deviceInfo) {
    return FittedBox(
      child: Text(
        widget.cartItem.nameAr,
        style: TextStyle(
            fontSize: getFontSizeVersion2(deviceInfo) - 10,
            color: Colors.lightBlue),
      ),
    );
  }

  Widget buildProductImage(DeviceInfo deviceInfo) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: TrimCachedImage(
        src: widget.cartItem.imageName,
      ),
      // child: Image.asset(
      //   'assets/images/shampoo1.jpg',
      //   height: double.infinity,
      //   fit: BoxFit.fill,
      // ),
    );
  }
}

class ConfirmDeleteItem extends StatelessWidget {
  const ConfirmDeleteItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text('Are you sure to delete this item ?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              return true;
            },
            child: Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No')),
      ],
    );
  }
}
