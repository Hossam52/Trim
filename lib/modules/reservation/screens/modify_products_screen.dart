import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/BuildRawMaterialButton.dart';
import 'package:trim/general_widgets/confirm_cancel_buttons.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/modules/market/models/Product.dart';
import 'package:trim/modules/reservation/cubits/update_order_cubit.dart';
import 'package:trim/modules/reservation/cubits/update_order_states.dart';
import 'package:trim/modules/reservation/models/UpdateArea.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class ModifyProductsScreen extends StatefulWidget {
  static String routeName = 'modifyProductsScreen';
  @override
  _ModifyProductsScreenState createState() => _ModifyProductsScreenState();
}

class _ModifyProductsScreenState extends State<ModifyProductsScreen> {
  OrderModel orderModel;
  bool isFirst = true;
  @override
  void didChangeDependencies() {
    if (isFirst) {
      orderModel = ModalRoute.of(context).settings.arguments as OrderModel;
      isFirst = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<UpdateArea> tabs = allTabsProducts(context, orderModel);
    return BlocProvider(
      create: (_) => UpdateOrderCubit(order: orderModel),
      child: Builder(builder: (context) {
        UpdateOrderCubit.getInstance(context).getAllProducsts();
        return Scaffold(
          body: SafeArea(
            child: DefaultTabController(
                length: tabs.length,
                initialIndex: 0,
                child: Column(
                  children: [
                    TabBar(
                        isScrollable: true,
                        labelColor: Theme.of(context).primaryColor,
                        tabs: tabs.map((e) => e.tabWidget).toList()),
                    Expanded(
                      child: InfoWidget(
                        responsiveWidget: (context, deviceInfo) => TabBarView(
                            children:
                                tabs.map((e) => e.contentWidget).toList()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      child: ConfirmCancelButtons(onPressConfirm: () {
                        print('Hello world');
                      }),
                    ),
                  ],
                )),
          ),
        );
      }),
    );
  }
}

List<UpdateArea> allTabsProducts(BuildContext context, OrderModel products) {
  return [
    UpdateArea(
      text: getWord('Modify', context),
      contentWidget: InfoWidget(responsiveWidget: (context, deviceInfo) {
        UpdateOrderCubit updateOrderCubit =
            UpdateOrderCubit.getInstance(context);
        return BlocConsumer<UpdateOrderCubit, UpdateOrderStates>(
          builder: (_, state) {
            if (state is LoadingOrderData)
              return Center(
                child: CircularProgressIndicator(),
              );
            return ListView.separated(
                itemBuilder: (context, index) => productModifiedItem(
                    deviceInfo: deviceInfo,
                    product: updateOrderCubit.products[index],
                    context: context,
                    index: index),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: updateOrderCubit.products.length);
          },
          listener: (_, state) {},
        );
      }),
    ),
    UpdateArea(
      text: 'اضافة',
      contentWidget: Center(
        child: Text('addition'),
      ),
    ),
  ];
}

Widget productModifiedItem(
    {DeviceInfo deviceInfo, Product product, BuildContext context, int index}) {
  return Container(
    height: deviceInfo.orientation == Orientation.portrait
        ? deviceInfo.localHeight / 4
        : deviceInfo.localHeight / 2,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildProductImage(deviceInfo, product.productImage),
          ),
          Expanded(
              flex: 3,
              child: buildProductDetails(deviceInfo, context, index, product)),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: deviceInfo.type == deviceType.mobile ? 40 : 55,
              ),
              onPressed: () async {
                UpdateOrderCubit.getInstance(context).removeProduct(index);
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildProductImage(DeviceInfo deviceInfo, String imageSrc) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: TrimCachedImage(
      src: imageSrc,
    ),
  );
}

Widget buildProductDetails(DeviceInfo deviceInfo, BuildContext context,
    int itemIndex, Product product) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
          child: buildProductName(
              deviceInfo, isArabic ? product.nameAr : product.nameEn)),
      Expanded(
          child: buildTotalPrice(
              deviceInfo,
              context,
              double.parse(product.productQuantity) *
                  double.parse(product.productPrice))),
      Expanded(
          child: buildActionButtons(deviceInfo, context, itemIndex, product)),
    ],
  );
}

Widget buildProductName(DeviceInfo deviceInfo, String productName) {
  return FittedBox(
    child: Text(
      productName,
      //   isArabic ? widget.cartItem.nameAr : widget.cartItem.nameEn,
      style: TextStyle(
          fontSize: getFontSizeVersion2(deviceInfo) - 10,
          color: Colors.lightBlue),
    ),
  );
}

Widget buildTotalPrice(
    DeviceInfo deviceInfo, BuildContext context, double totalPrice) {
  return FittedBox(
    child: Text(
      getWord('total price', context) + ': ${totalPrice.toStringAsFixed(1)}',
      style: TextStyle(
          fontSize: getFontSizeVersion2(deviceInfo) - 13, color: Colors.green),
    ),
  );
}

Widget buildActionButtons(
    DeviceInfo deviceInfo, BuildContext context, int index, Product product) {
  bool isEnabled = product.productQuantity == '10';

  return Row(
    children: [
      BuildRawMaterialButton(
        icon: Icons.add,
        pressed: isEnabled
            ? null
            : () {
                UpdateOrderCubit.getInstance(context).updateProductPlus(index);
              },
        deviceInfo: deviceInfo,
      ),
      Text(
        '${product.productQuantity}',
        style: TextStyle(fontSize: getFontSizeVersion2(deviceInfo) - 5),
      ),
      BuildRawMaterialButton(
        icon: Icons.remove,
        pressed: () {
          UpdateOrderCubit.getInstance(context).updateProductMinus(index);
        },
        deviceInfo: deviceInfo,
      ),
    ],
  );
}
