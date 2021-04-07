import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';

class SalonLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 200,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/2.jpg',
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Container(
                    height: 80,
                    alignment: Alignment.bottomCenter,
                    color: Colors.grey,
                    child: IconButton(
                      icon: Icon(Icons.favorite_outline),
                      onPressed: () {},
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
