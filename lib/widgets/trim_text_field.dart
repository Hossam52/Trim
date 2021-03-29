import 'package:flutter/material.dart';
import '../constants/app_constant.dart';

class TrimTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeHolder;
  final bool password;
  final Function(String) validator;
  final TextInputType textInputType;

  const TrimTextField({
    @required this.controller,
    @required this.placeHolder,
    this.validator,
    this.textInputType = TextInputType.text,
    this.password = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText: password,
        textDirection: TextDirection.rtl,
        controller: controller,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
          fillColor: filledColor,
          filled: true,
          hintText: placeHolder,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(roundedRadius),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
