import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final VoidCallback pressed;
  final String icon;
  final String name;
  final bool directionRoundedRight;
  final bool active;
  ChoiceButton(
      {this.directionRoundedRight,
      this.icon,
      this.name,
      this.pressed,
      this.active = false});
  @override
  Widget build(BuildContext context) {
    Color activeColor = Colors.white;
    Color backgroundColor = Colors.blue[900];
    Radius radius = Radius.circular(25);
    return Expanded(
      child: TextButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              active ? backgroundColor : Colors.white),
          foregroundColor:
              MaterialStateProperty.all(active ? activeColor : Colors.black87),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(width: 0.25, color: Colors.black),
              borderRadius: BorderRadius.only(
                topRight: directionRoundedRight ? radius : Radius.zero,
                bottomRight: directionRoundedRight ? radius : Radius.zero,
                topLeft: !directionRoundedRight ? radius : Radius.zero,
                bottomLeft: !directionRoundedRight ? radius : Radius.zero,
              ),
            ),
          ),
        ),
        onPressed: pressed,
        icon: Image.asset(
          icon,
          color: active ? activeColor : null,
          height: 25,
          width: 25,
        ),
        label: Text(name),
      ),
    );
  }
}
