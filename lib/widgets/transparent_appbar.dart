import 'package:flutter/material.dart';

class TransparentAppBar extends AppBar {
  TransparentAppBar()
      : super(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: Colors.black,
          ),
        );
}
