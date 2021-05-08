import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';

class NavigatePages extends StatelessWidget {
  final void Function(BuildContext) nextPage;
  final void Function(BuildContext) prevPage;
  final int pageNumber;

  const NavigatePages(
      {Key key,
      @required this.nextPage,
      @required this.prevPage,
      @required this.pageNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => prevPage(context)),
        Text('$pageNumber'),
        IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () => nextPage(context)),
      ],
    );
  }
}
