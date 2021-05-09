import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_states.dart';
import 'package:trim/modules/market/screens/BadgeScreen.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<CartBloc, CartStates>(builder: (_, state) {
      if (state is InitialStateGetCartItems)
        return CircularProgressIndicator();
      else
        return Badge(
            showBadge: true,
            badgeContent:
                Text('${BlocProvider.of<CartBloc>(context).items.length}'),
            child: IconButton(
              iconSize: width / 10,
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: ()
              {
                Navigator.pushNamed(context, BadgeScrren.routeName);
              },
              padding: const EdgeInsets.all(0),
            ),);
    });
  }
}
