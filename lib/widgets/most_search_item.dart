import 'package:flutter/material.dart';

class MostSearchItem extends StatelessWidget {
  final String imagePath;

  const MostSearchItem({this.imagePath});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRRect(
      child: Container(
          height: width / 3.8,
          width: width / 3.8,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          )),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
