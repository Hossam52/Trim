import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final double offer;
  const CarouselItem({Key key, this.imagePath, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.fill,
        ),
        Positioned(
          bottom: 50,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('BEAUTY SALON offer 50%',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
