import 'package:flutter/material.dart';

class BuildStars extends StatelessWidget {
  final double stars;
  final double width;

  const BuildStars({Key key, @required this.stars, @required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (starIndex) => Flexible(
          child: Container(
            margin: EdgeInsets.all(2),
            child: stars - (starIndex) == 0.5
                ? Icon(Icons.star_half_sharp,
                    color: Colors.yellow[800], size: width * 0.1)
                : starIndex + 1 > stars
                    ? Icon(Icons.star_outline_sharp, size: width * 0.1)
                    : Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                        size: width * 0.1,
                      ),
          ),
        ),
      ),
    );
  }
}
