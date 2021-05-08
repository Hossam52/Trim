import 'package:flutter/material.dart';

class BuildSearchWidget extends StatelessWidget {
  final Function pressed;
  final Future Function(String value) onChanged;
  BuildSearchWidget({this.pressed, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: TextFormField(
        onChanged: onChanged,
        validator: (value) {
          if (value.isEmpty)
            return 'please Enter searched word';
          else
            return null;
        },
        decoration: InputDecoration(
          //  contentPadding: EdgeInsets.only(right: 10),
            hintText: 'Search for',
            prefixIcon: ElevatedButton(
                onPressed: pressed,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))))),
            fillColor: Colors.grey[200],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            )),
      ),
    ));
  }
}
