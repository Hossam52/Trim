import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/payment/cubits/address_cubit.dart';
import 'package:trim/modules/payment/cubits/address_states.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class DeliveryWidget extends StatefulWidget {
  DeliveryWidget({
    @required this.fontSize,
    @required this.secondaryColor,
    @required this.pressed,
    @required this.deviceInfo,
    @required this.addressController,
    @required this.phoneController,
  });

  final double fontSize;
  final Color secondaryColor;
  final Function pressed;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final DeviceInfo deviceInfo;

  @override
  _DeliveryWidgetState createState() => _DeliveryWidgetState();
}

class _DeliveryWidgetState extends State<DeliveryWidget> {
  final formKey = GlobalKey<FormState>();
  String deliveryStartDate = '';
  String deliveryEndDate = '';
  @override
  void initState() {
    super.initState();
    deliveryStartDate =
        DateFormat('dd MMM').format(DateTime.now().add(Duration(days: 2)));
    deliveryEndDate = deliveryEndDate =
        DateFormat('dd MMM').format(DateTime.now().add(Duration(days: 5)));
  }

  @override
  Widget build(BuildContext context) {
    deliveryStartDate = DateFormat('dd MMM', isArabic ? 'ar' : 'en')
        .format(DateTime.now().add(Duration(days: 2)));
    deliveryEndDate = deliveryEndDate =
        DateFormat('dd MMM', isArabic ? 'ar' : 'en')
            .format(DateTime.now().add(Duration(days: 5)));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          leading: TextButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
              TextStyle(
                  fontSize: widget.fontSize - 5, color: Colors.lightBlueAccent),
            )),
            onPressed: () async {
              await changeAddress(context, formKey);
            },
            child: Text(getWord('change', context)),
          ),
          trailing: Text(
            getWord('address details', context),
            style: TextStyle(
                fontSize: widget.fontSize - 5, color: widget.secondaryColor),
          ),
        ),
        Container(
          height: widget.deviceInfo.localHeight *
              (widget.deviceInfo.orientation == Orientation.portrait
                  ? 0.285
                  : .7),
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.white),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: BlocBuilder<AddressCubit, AddressStates>(
              builder: (_, state) => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppCubit.getInstance(context).name,
                      style: TextStyle(
                          fontSize: widget.fontSize, color: Colors.black)),
                  buildAddressRow(getWord('City', context),
                      AddressCubit.getInstance(context).getCity(context)),
                  Divider(),
                  buildAddressRow(getWord('Country', context),
                      AddressCubit.getInstance(context).getCountry(context)),
                  Divider(),
                  buildAddressRow(getWord('Street', context),
                      AddressCubit.getInstance(context).getStreet(context)),
                  Divider(),
                  buildAddressRow(getWord('Phone', context),
                      AddressCubit.getInstance(context).getPhone(context)),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            getWord('choice deliver method', context),
            style: TextStyle(
                fontSize: widget.fontSize - 5, color: Color(0xffCBCBCD)),
          ),
        ),
        Container(
          height: widget.deviceInfo.localHeight *
              (widget.deviceInfo.orientation == Orientation.portrait
                  ? 0.22
                  : .45),
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              leading: Radio(
                value: '1',
                groupValue: '1',
                onChanged: (val) {},
              ),
              title: Text(
                getWord('delivery to home', context),
                style: TextStyle(fontSize: widget.fontSize - 3),
              ),
              subtitle: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        getWord('Arrive between days', context) +
                            deliveryStartDate +
                            getWord('and', context) +
                            deliveryEndDate +
                            getWord(
                                'Please checkout dates in payment coninue page',
                                context),
                        style: TextStyle(
                          fontSize: widget.deviceInfo.orientation ==
                                  Orientation.portrait
                              ? widget.deviceInfo.localWidth * 0.032
                              : widget.deviceInfo.localWidth * 0.0225,
                        )),
                    Row(
                      children: [
                        Text(
                          getWord('Shipping expenses', context) + ' :',
                          style: TextStyle(
                            fontSize: widget.deviceInfo.orientation ==
                                    Orientation.portrait
                                ? widget.deviceInfo.localWidth * 0.032
                                : widget.deviceInfo.localWidth * 0.0225,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppCubit.getInstance(context).shippingFee.toString(),
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.fontSize - 4),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DefaultButton(
            text: getWord('Continue to pay', context),
            onPressed: AddressCubit.getInstance(context).validateClassData()
                ? widget.pressed
                : null),
      ],
    );
  }

  Widget buildAddressRow(String key, String value) {
    return Row(
      children: [
        Text(key, style: TextStyle(fontSize: widget.fontSize - 5)),
        Spacer(),
        Text(
          value,
          style: TextStyle(
              fontSize: widget.fontSize - 5, color: widget.secondaryColor),
        ),
      ],
    );
  }
}
