import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/CanceledReasons.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class CancelReasons extends StatefulWidget {
  final DeviceInfo deviceInfo;
  CancelReasons(this.deviceInfo);
  @override
  _CancelReasonsState createState() => _CancelReasonsState();
}

class _CancelReasonsState extends State<CancelReasons> {
  String selectedvalue = '';
  FocusNode focusNode;
  final controller = TextEditingController();
  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = getFontSize(widget.deviceInfo);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 45),
        ...canceledReasons
            .map(
              (reason) => buildCancelReasonItem(
                fontSize: fontSize,
                reason: reason,
                selected: selectedvalue,
                press: (selected) {
                  setState(() {
                    selectedvalue = selected;
                  });
                },
              ),
            )
            .toList(),
        if (selectedvalue == canceledReasons[6])
          buildAnotherReasonField(context),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: buildButton(context),
        ),
      ],
    );
  }

  DefaultButton buildButton(BuildContext context) {
    return DefaultButton(
        onPressed: () async {
          final reservationItem = ReservationCubit.getInstance(context)
              .getSelectedReservationItem();
          if (selectedvalue == '') {
            Navigator.pop(context, selectedvalue);
          } else {
            final verifyCancel = await exitConfirmationDialog(
                context, 'Are you sure to cancel this order?');
            if (verifyCancel == true) {
              String cancelReason = canceledReasons[canceledReasons.length - 1];
              if (selectedvalue !=
                  cancelReason) //Not Equal to last emlent [another reason]
                cancelReason = selectedvalue;
              else
                cancelReason = controller.text;
              ReservationCubit.getInstance(context).cancelOrder(
                  orderId: reservationItem.id, cancelReason: cancelReason);
            }
            Navigator.pop(context, selectedvalue);
          }
        },
        text: 'OK',
        color: Colors.black);
  }

  TextFormField buildAnotherReasonField(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        //contentPadding: ,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        hintText: 'What reason for cancel?',
        labelText: 'The reason',
      ),
      onSaved: (reason) {
        selectedvalue = reason;
        print(selectedvalue);
        FocusScope.of(context).unfocus();
      },
    );
  }

  Widget buildCancelReasonItem(
      {@required String reason,
      @required String selected,
      @required void Function(String) press,
      @required double fontSize}) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading:
          Radio<String>(groupValue: selected, value: reason, onChanged: press),
      title: Text(
        reason,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize),
      ),
      onTap: () {
        press(reason);
      },
    );
  }
}
