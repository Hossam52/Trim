import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/payment/cubits/address_cubit.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/modules/payment/screens/payment_methods_screen.dart';
import 'package:trim/modules/reservation/Bloc/order_cubit.dart';
import 'package:trim/modules/reservation/Bloc/order_states.dart';
import 'package:trim/modules/reservation/Bloc/products_order_bloc.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/market/widgets/build_listTile_confirm.dart';
import '../../../general_widgets/copoun_text_field.dart';

class BuildDetailsOrderPrice extends StatefulWidget {
  final double fontSize;
  final DeviceInfo deviceInfo;
  final Function pressed;
  final int stepNumber;
  final String address;
  final String phone;
  BuildDetailsOrderPrice(
      {@required this.fontSize,
      @required this.pressed,
      @required this.deviceInfo,
      @required this.stepNumber,
      @required this.paymentMethod,
      @required this.address,
      @required this.phone});
  final PaymentMethod paymentMethod;

  @override
  _BuildDetailsOrderPriceState createState() => _BuildDetailsOrderPriceState();
}

class _BuildDetailsOrderPriceState extends State<BuildDetailsOrderPrice> {
  CartBloc cartBloc;
  bool correctCopon = false;
  String coupon;
  int discountValue = 0;

  TextEditingController controller;
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(
      context,
    );
    controller = TextEditingController();
    shippingFee = AppCubit.getInstance(context).shippingFee ?? 10;
    super.initState();
  }

  int shippingFee;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.deviceInfo.localHeight *
          (widget.deviceInfo.orientation == Orientation.portrait ? 0.6 : 0.82),
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
              CoupounTextField(
                controller: controller,
                enabled: correctCopon,
                updateUi: (bool coorectCopon, int discount) {
                  if (discount == null || discount == 0)
                    setState(() {
                      correctCopon = false;
                    });
                  else {
                    setState(() {
                      correctCopon = true;
                      discountValue = discount;
                    });
                  }
                },
              ),
            BuildListTileCofirm(
              leading: translatedWord('total', context),
              trailing: '${cartBloc.getTotalPrice().toStringAsFixed(2)} ' +
                  translatedWord('bound', context),
              fontSize: widget.fontSize,
            ),
            BuildListTileCofirm(
              leading: translatedWord('shipping', context),
              trailing: '$shippingFee ' + translatedWord('bound', context),
              fontSize: widget.fontSize,
            ),
            BuildListTileCofirm(
              leading: translatedWord('Discount', context),
              trailing:
                  discountValue.toString() + translatedWord('bound', context),
              fontSize: widget.fontSize,
            ),
            Divider(
              endIndent: 10,
              height: 4,
              color: Colors.black,
            ),
            BuildListTileCofirm(
              leading: translatedWord('total price', context),
              trailing:
                  '${(cartBloc.getTotalPrice() + shippingFee - discountValue).toStringAsFixed(2)} ' +
                      translatedWord('bound', context),
              fontSize: widget.fontSize,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocConsumer<OrderCubit, OrderStates>(
                listener: (_, state) {},
                builder: (_, state) => DefaultButton(
                  onPressed: state is LoadingOrderState
                      ? null
                      : () async {
                          widget.stepNumber == 2
                              ? await confirmOrderFunction(
                                  context, discountValue)
                              : widget.pressed();
                        },
                  text: widget.stepNumber == 2
                      ? translatedWord('Confirm order', context)
                      : translatedWord('continue to pay', context),
                  widget:
                      state is LoadingOrderState ? TrimLoadingWidget() : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> confirmOrderFunction(
      BuildContext context, var discountValue) async {
    final deliveryInfo = AddressCubit.getInstance(context);
    final address = deliveryInfo.getStreet(context) +
        ' ' +
        deliveryInfo.getCity(context) +
        ' ' +
        deliveryInfo.getCountry(context);
    double totalPrice =
        (cartBloc.getTotalPrice() + shippingFee - discountValue);
    if (widget.paymentMethod == PaymentMethod.VisaMaster)
      await Navigator.pushNamed(context, PaymentMethodsScreen.routeName,
          arguments: {'totalPrice': totalPrice, 'showCashMethod': false});
    if (widget.paymentMethod == PaymentMethod.Cash ||
        (PaymentCubit.getInstance(context).successPayment &&
            PaymentCubit.getInstance(context).paymentMethod !=
                PaymentMethod.Cash)) {
      try {
        final cartBloc = BlocProvider.of<CartBloc>(context);
        List<CartItem> items = cartBloc.getCartList();
        final productsOrderBloc = BlocProvider.of<ProductsOrderBloc>(context);

        await OrderCubit.getInstance(context).makeOrderProducts(
            cartItems: items,
            coupon: controller.text,
            phone: deliveryInfo.phone,
            address: address,
            paymentMethod: widget.paymentMethod == PaymentMethod.Cash
                ? 'Cash'
                : 'VisaMatercard');
        bool checkValue = productsOrderBloc.discount == null ? false : true;
        if (checkValue && productsOrderBloc.discount != 0) {
          Fluttertoast.showToast(
              msg:
                  'we will apply discount with ${productsOrderBloc.discount} when paying');
        }

        if (OrderCubit.getInstance(context).state is! ErrorOrderState) {
          cartBloc.add(DeleteAllItemsInCart());

          await Navigator.pushNamed(
              context,
              ReservationsScreen
                  .routeName); //Go to reservation page to view the order
          Navigator.pop(context); //for delivery screen
          Navigator.pop(context); //for cart screen

        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: translatedWord(
                'Please Make sure from internet connection', context));
      }
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
              onPressed: correctCopon
                  ? null
                  : () async {
                      try {
                        FocusScope.of(context).unfocus();
                        if (controller.text.isEmpty || controller.text == ' ') {
                          Fluttertoast.showToast(
                              msg: translatedWord(
                                  'Pleas Enter coupoun code', context));
                        } else {
                          final response = await DioHelper.postData(
                              url: 'winCoupone',
                              body: {
                                'code': controller.text,
                              });
                          Fluttertoast.showToast(
                              msg: response.data['success'].toString() +
                                  "هذا  ");
                          if (!response.data['success']) {
                            Fluttertoast.showToast(
                                msg: isArabic
                                    ? 'الكوبون غير متاح'
                                    : response.data['message']);
                          } else {
                            setState(() {
                              correctCopon = true;
                              discountValue =
                                  int.parse(response.data['data']['price']);
                            });
                          }
                        }
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: translatedWord(
                                'Please Make sure from internet connection',
                                context));
                      }
                    },
              text: translatedWord('apply', context),
              color: Color(0xff2C73A8),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextFormField(
                enabled: !correctCopon,
                controller: controller,
                decoration: InputDecoration(
                  hintText: translatedWord('coupon code', context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
