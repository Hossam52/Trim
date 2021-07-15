import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class ConfirmCancelButtons extends StatelessWidget {
  final VoidCallback onPressConfirm;

  const ConfirmCancelButtons({
    Key key,
    @required this.onPressConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 2,
            child: DefaultButton(
              text: getWord('Confirm', context),
              onPressed: onPressConfirm,
              color: Colors.green,
            )),
        Expanded(child: Container()),
        Expanded(
            flex: 2,
            child: DefaultButton(
                text: getWord('Cancel', context),
                onPressed: () async {
                  final goBack = await confirmBack(context);
                  if (goBack) Navigator.pop(context);
                },
                color: Colors.red)),
      ],
    );
  }
}
