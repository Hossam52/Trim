import 'package:flutter/material.dart';

class BuildOffersItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/barber.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
      Positioned(
          bottom: 30,
          child: Container(
              padding: EdgeInsets.all(4),
              child: Text(
                  // 'عرض   50%   لفترة محدودة '
                  'Limited offer 50%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              decoration: BoxDecoration(
                color: Color(0xff676363).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ))),
    ]);
  }
}