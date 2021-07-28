import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';

class GenderSelectionWidget extends StatelessWidget {
  final Gender selectedGender;
  final Function changeGender;

  const GenderSelectionWidget({Key key, this.selectedGender, this.changeGender})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RadioListTile(
              title: Text(translatedWord('Female', context)),
              value: Gender.Female,
              groupValue: selectedGender,
              onChanged: changeGender),
        ),
        Expanded(
          child: RadioListTile(
              title: Text(translatedWord('Male', context)),
              value: Gender.Male,
              groupValue: selectedGender,
              onChanged: changeGender),
        ),
      ],
    );
  }
}
