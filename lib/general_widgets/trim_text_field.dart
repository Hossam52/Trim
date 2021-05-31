import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import '../constants/app_constant.dart';

class TrimTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeHolder;
  final bool password;
  final Function(String) validator;
  final TextInputType textInputType;
  final Widget prefix;
  final bool readOnly;
  final int maxLength;
  final TextInputFormatter inputFormatter;
  const TrimTextField({
    @required this.controller,
    @required this.placeHolder,
    this.validator,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.prefix,
    this.readOnly = false,
    this.maxLength,
    this.inputFormatter,
  });
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Container(
        margin: const EdgeInsets.all(10),
        child: Directionality(
          textDirection: !isArabic ? TextDirection.ltr : TextDirection.rtl,
          child: TextFormField(
            inputFormatters: inputFormatter != null ? [inputFormatter] : null,
            maxLength: maxLength,
            readOnly: readOnly,
            keyboardType: textInputType,
            validator: validator,
            obscureText: password,
            controller: controller,
            style: TextStyle(fontSize: getFontSizeVersion2(deviceInfo)),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              isDense: true,
              prefixIcon: prefix,
              hintMaxLines: 2,
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
        ),
      ),
    );
  }
}
