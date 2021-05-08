import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/cubit/cart_states.dart';
import 'package:trim/modules/market/cubit/categories_cubit.dart';
import 'package:trim/modules/market/cubit/categories_states.dart';
import 'package:trim/modules/market/models/Category.dart';
import 'package:trim/modules/market/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/market/widgets/cart.dart';
import 'package:trim/modules/market/widgets/category_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/BuildSearchWidget.dart';

class ShoppingScreen extends StatefulWidget {
  static final routeName = 'shoppingScreen';
  final void Function(int categoryIndex) setCategoryIndex;

  const ShoppingScreen({Key key, this.setCategoryIndex}) : super(key: key);

  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  CartBloc cartBloc;
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartItemsEvent());
    super.initState();
  }

  @override
  void dispose() {
    print('Dispose shopping screen');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: InfoWidget(
            responsiveWidget: (context, deviceInfo) {
              print(deviceInfo.type);
              return Container(
                height: deviceInfo.localHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: buildHeader(),
                    ),
                    BlocBuilder<AllcategoriesCubit, CategoriesStates>(
                        builder: (_, state) {
                      if (state is LoadingState || state is InitialState)
                        return Center(child: CircularProgressIndicator());
                      else if (state is LoadedState) {
                        List<Category> categoriess = state.categories;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: buildCategories(deviceInfo, categoriess),
                          ),
                        );
                      } else
                        return Center(
                            child: Text(
                                'Please Make sure from internet connection'));
                    })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  GridView buildCategories(DeviceInfo deviceInfo, List<Category> categoriess) {
    return GridView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
        //  widget.setCategoryIndex(index);
          Navigator.pushNamed(
            context,
            CategoryProductsScreen.routeName,
            arguments: categoriess[index].id,
          );
        },
        child:
            CategoryItem(category: categoriess[index], deviceInfo: deviceInfo),
      ),
      itemCount: categoriess.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          childAspectRatio: deviceInfo.type == deviceType.mobile ? 0.78 : 1.4,
          mainAxisSpacing: 10),
    );
  }

  Row buildHeader() {
    return Row(
      children: [
        Cart(),
        Expanded(
          child: BuildSearchWidget(
            onChanged: (value) async {
              print("search\n");
            },
          ),
        ),
      ],
    );
  }
}
