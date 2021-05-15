import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_text_field.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/modules/payment/models/StepsCompleteOrder.dart';
import 'package:trim/modules/payment/screens/payment_detail_screen.dart';
import 'package:trim/modules/payment/screens/payment_methods_screen.dart';
import 'package:trim/modules/reservation/Bloc/products_order_bloc.dart';
import 'package:trim/modules/reservation/Bloc/products_order_events.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/screens/ReservationDetailsScreen.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/market/widgets/build_listTile_confirm.dart';

class BuildDetailsOrderPrice extends StatefulWidget {
  BuildDetailsOrderPrice(
      {@required this.fontSize,
      @required this.pressed,
      @required this.deviceInfo,
      @required this.stepNumber,
      @required this.paymentMethod});
  final PaymentMethod paymentMethod;
  final double fontSize;
  final DeviceInfo deviceInfo;
  final Function pressed;
  final int stepNumber;

  @override
  _BuildDetailsOrderPriceState createState() => _BuildDetailsOrderPriceState();
}

class _BuildDetailsOrderPriceState extends State<BuildDetailsOrderPrice> {
  CartBloc cartBloc;
  String coupon;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);
    return Container(
      height: widget.deviceInfo.localHeight *
          (widget.deviceInfo.orientation == Orientation.portrait ? 0.50 : 0.82),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.stepNumber == 2)
              getCopunTextField(context: context, controller: controller),
            BuildListTileCofirm(
              leading: getWord('total', context),
              trailing: '${cartBloc.getTotalPrice().toStringAsFixed(2)} ' +
                  getWord('bound', context),
              fontSize: widget.fontSize,
            ),
            BuildListTileCofirm(
              leading: getWord('shipping', context),
              trailing: '20 ' + getWord('bound', context),
              fontSize: widget.fontSize,
            ),
            Divider(
              endIndent: 10,
              height: 4,
              color: Colors.black,
            ),
            BuildListTileCofirm(
              leading: getWord('total price', context),
              trailing:
                  '${(cartBloc.getTotalPrice() + 20).toStringAsFixed(2)} ' +
                      getWord('bound', context),
              fontSize: widget.fontSize,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: widget.stepNumber == 2
                    ? confirmOrderFunction(context)
                    : widget.pressed,
                child: Text(
                  widget.stepNumber == 2
                      ? getWord('Confirm order', context)
                      : getWord('continue to pay', context),
                  style: TextStyle(fontSize: widget.fontSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  VoidCallback confirmOrderFunction(BuildContext context) {
    return () async {
      double totalPrice = (cartBloc.getTotalPrice() + 20);
      if (widget.paymentMethod == PaymentMethod.VisaMaster)
        await Navigator.pushNamed(context, PaymentMethodsScreen.routeName,
            arguments: {'totalPrice': totalPrice, 'showCashMethod': false});
      if (widget.paymentMethod == PaymentMethod.Cash ||
          (PaymentCubit.getInstance(context).successPayment &&
              PaymentCubit.getInstance(context).paymentMethod !=
                  PaymentMethod.Cash)) {
        try {
          CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
          List<CartItem> items = cartBloc.getCartList();
          ProductsOrderBloc productsOrderBloc =
              BlocProvider.of<ProductsOrderBloc>(context);
          productsOrderBloc.add(PostDataOrderProducts(productsOrder: items));
          cartBloc.add(DeleteAllItemsInCart());

          ReservationCubit.getInstance(context).loadMyOrders(refreshPage: true);
          await Navigator.pushNamed(
              context,
              ReservationsScreen
                  .routeName); //Go to reservation page to view the order
          Navigator.pop(context); //for delivery screen
          Navigator.pop(context); //for cart screen
          Navigator.pop(
              context); //for products screen and stay at categories screen
        } catch (e) {
          print('Inside error order');
        }
      }
    };
  }
}

Widget getCopunTextField(
    {BuildContext context, TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: DefaultButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (controller.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: getWord('Pleas Enter coupoun code', context));
              } else {
                final response =
                    await DioHelper.postData(url: 'winCoupone', body: {
                  'code': controller.text,
                });
                if (!response.data['success']) {
                  Fluttertoast.showToast(
                      msg: isArabic
                          ? 'الكوبون غير متاح'
                          : response.data['message']);
                } else {
                  print(response.data);
                  print(controller.text);
                }
              }
            },
            text: getWord('apply', context),
            color: Color(0xff2C73A8),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: getWord('coupon code', context),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
