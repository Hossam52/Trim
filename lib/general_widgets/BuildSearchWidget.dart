import 'package:flutter/material.dart';

class BuildSearchWidget extends StatelessWidget {
  final Future Function(String value) onChanged;
  final String Function(String checkValue) validator;
  final TextEditingController textEditingController;
  final Widget prefixButton;
  BuildSearchWidget({this.onChanged, this.validator, this.prefixButton,this.textEditingController});
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: TextFormField(
        controller: textEditingController,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
            hintText: 'Search for',
            prefixIcon: prefixButton,
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
