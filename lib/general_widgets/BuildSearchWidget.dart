import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';

class BuildSearchWidget extends StatelessWidget {
  final Future Function(String value) onChanged;
  BuildSearchWidget({this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: getWord('Search for', context),
            prefixIcon: Icon(Icons.search,color: Colors.lightBlue,),
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            ),
      ),
    ),
    );
  }
}
