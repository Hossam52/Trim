import 'package:flutter/material.dart';

class TrimCard extends StatelessWidget {
  final Widget child;

  const TrimCard({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 10,
        shadowColor: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
