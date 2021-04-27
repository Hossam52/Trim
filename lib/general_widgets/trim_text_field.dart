import 'package:flutter/material.dart';
import '../constants/app_constant.dart';

class TrimTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeHolder;
  final bool password;
  final Function(String) validator;
  final TextInputType textInputType;
  final Widget prefix;
  final bool readOnly;
  const TrimTextField({
    @required this.controller,
    @required this.placeHolder,
    this.validator,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.prefix,
    this.readOnly = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        readOnly: readOnly,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText: password,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          isDense: true,
          prefixIcon: prefix,
          prefix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          fillColor: filledColor,
          filled: true,
          hintText: placeHolder,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(roundedRadius),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
