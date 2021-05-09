import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/api_path.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/payment/models/StepsCompleteOrder.dart';
import 'package:trim/utils/services/rest_api_service.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/market/widgets/build_listTile_confirm.dart';

class BuildDetailsOrderPrice extends StatelessWidget {
  BuildDetailsOrderPrice(
      {@required this.fontSize,
      @required this.pressed,
      @required this.deviceInfo,
      @required this.stepNumber});

  final double fontSize;
  final DeviceInfo deviceInfo;
  final Function pressed;
  final int stepNumber;
  CartBloc cartBloc;
  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of(context);
    return Container(
      height: deviceInfo.localHeight *
          (deviceInfo.orientation == Orientation.portrait ? 0.40 : 0.75),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          BuildListTileCofirm(
            leading: 'الاجمالي',
            trailing: '${cartBloc.getTotalPrice().toStringAsFixed(2)} جنيه',
            fontSize: fontSize,
          ),
          BuildListTileCofirm(
            leading: 'الشحن',
            trailing: '20 جنيه',
            fontSize: fontSize,
          ),
          Divider(
            endIndent: 10,
            height: 4,
            color: Colors.black,
          ),
          BuildListTileCofirm(
            leading: 'السعر الكلي',
            trailing:
                '${(cartBloc.getTotalPrice() + 20).toStringAsFixed(2)} جنيه',
            fontSize: fontSize,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: stepNumber == 2
                  ? () async {
                      CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
                      List<CartItem> items = cartBloc.getCartList();
                        List<Map<String,dynamic>>productsOrder=[];
                        for(CartItem item in items)
                        productsOrder.add({
                          'product_id':item.id,
                          'quantity':item.quantity,

                        });
                      final response = await DioHelper.postData(
                          url: newOrderWithProduct,
                          body: {
                           'products':productsOrder,
                          });
                      print(response.data);
                      cartBloc.add(DeleteAllItemsInCart());
                    }
                  : pressed,
              child: Text(
                stepNumber == 2
                    ? 'تأكيد'
                    : 'المواصلة في ${stepsCompleteOrder[stepNumber - 1]}',
                style: TextStyle(fontSize: fontSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
