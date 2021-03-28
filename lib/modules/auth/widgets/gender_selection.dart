import 'package:flutter/material.dart';
import '../screens/registration_screen.dart';

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
              title: Text('أنثي'),
              value: Gender.Female,
              groupValue: selectedGender,
              onChanged: changeGender),
        ),
        Expanded(
          child: RadioListTile(
              title: Text('ذكر'),
              value: Gender.Male,
              groupValue: selectedGender,
              onChanged: changeGender),
        ),
      ],
    );
  }
}
