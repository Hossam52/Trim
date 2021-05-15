import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';

class BuildSearchWidget extends StatelessWidget {
  final Future Function(String value) onChanged;
  final String initialText;
  BuildSearchWidget({this.onChanged, this.initialText});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = initialText;
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: getWord('Search for', context),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.lightBlue,
            ),
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    ));
  }
}
