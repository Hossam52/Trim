import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/availableCities.dart';
import 'package:trim/general_widgets/default_button.dart';

class BuildCitiesRadio extends StatefulWidget {
  @override
  _BuildCitiesRadioState createState() => _BuildCitiesRadioState();
}

class _BuildCitiesRadioState extends State<BuildCitiesRadio> {
  String selectedCity = availableCities[0];
  List<Widget> buildSelectedCity() {
    List<Widget> widgets = [];
    for (String city in availableCities) {
      widgets.add(
        ListTile(
          onTap: () {
            setState(() {
              selectedCity = city;
            });
          },
          leading: Radio<String>(
            value: city,
            groupValue: selectedCity,
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          ),
          title: Text(city),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...buildSelectedCity(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: DefaultButton(
              text: 'Search now',
              onPressed: () {
                Navigator.pop(context, selectedCity);
              },
              color: Colors.black,
            )),
      ],
    );
  }
}
