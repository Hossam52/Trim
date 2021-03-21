import 'package:flutter/material.dart';

class TrimStarItem extends StatelessWidget {
  final String personImagePath;
  final String name;
  final String stars;

  const TrimStarItem(
      {Key key, this.personImagePath, this.name = 'Person name', this.stars})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xfff6F6F6), borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.all(5),
      height: width / 2.5,
      width: width / 3.5,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            child: Container(
              width: width / 3.5,
              height: width / 5,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Image.asset(personImagePath, fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(name),
          _StarsRow(),
        ],
      ),
    );
  }
}

class _StarsRow extends StatelessWidget {
  final Icon _icon = Icon(Icons.star, color: Color(0xffFFBE44), size: 18);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [_icon, _icon, _icon, _icon, _icon],
      ),
    );
  }
}
