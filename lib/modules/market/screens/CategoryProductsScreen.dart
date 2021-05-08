import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/market/cubit/cart_events.dart';
import 'package:trim/modules/market/cubit/cart_states.dart';
import 'package:trim/modules/market/cubit/procucts_category_states.dart';
import 'package:trim/modules/market/cubit/products_category_cubit.dart';
import 'package:trim/modules/market/cubit/products_category_events.dart';
import 'package:trim/modules/market/cubit/search_bloc.dart';
import 'package:trim/modules/market/cubit/search_events.dart';
import 'package:trim/modules/market/cubit/search_states.dart';
import 'package:trim/modules/market/models/Product.dart';
import 'package:trim/modules/market/models/cartItem.dart';
import 'package:trim/modules/market/widgets/cart.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/BuildRawMaterialButton.dart';
import 'package:trim/general_widgets/BuildSearchWidget.dart';

class CategoryProductsScreen extends StatefulWidget {
  static final routeName = 'categoryProductScreen';
  final int categoryIndex;
  final void Function() backToCategories;
  CategoryProductsScreen({this.categoryIndex, this.backToCategories});

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  ProductsCategoryBloc productsBloc;
  CartBloc cartCubit;
  SearchBloc searchBloc;

  @override
  void dispose() {
    super.dispose();
    print('Dispose categoryProductScreen');
  }

  @override
  void initState() {
    productsBloc = BlocProvider.of<ProductsCategoryBloc>(context);
    cartCubit = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() 
  {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    int categoryId = ModalRoute.of(context).settings.arguments as int;
    productsBloc.add(FetchDataFromApi(categoryId: categoryId));
    super.didChangeDependencies();
  }

  GlobalKey globalKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController=TextEditingController();
  String searchedString;
  bool isCategory;
  @override
  Widget build(BuildContext context) {
    print('from here rebuild\n');
    isCategory = true;
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          backgroundColor: Colors.blue[800],

          // leading: BackButton(
          //   onPressed: () {
          //     widget.backToCategories();
          //   },
          // ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Cart(),
            )
          ],
          centerTitle: true,
          title: Text('Category Products'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InfoWidget(
              responsiveWidget: (context, deviceInfo) {
                return BlocConsumer<SearchBloc,SearchStates>(
                  listener: (_,state){},
                    builder:(_,state)=> Column(
                    children: [
                      BuildSearchWidget(
                        textEditingController: textEditingController,
                        prefixButton: ElevatedButton(
                            onPressed: () 
                            {
                              searchBloc.add(SearchEvent(
                                  searchWord: textEditingController.text,
                                  products: productsBloc.products));
                              print('Search bar products button search');
                              print(textEditingController.text);
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.cyan),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25))))),
                        onChanged: (value) async 
                        {
                          
                          searchBloc.add(SearchEvent(
                              searchWord: value,
                              products: productsBloc.products));
                          print('Search bar products');
                        },
                        validator: (value) 
                        {
                          if (value.isEmpty)
                            return 'Please Enter word to search';
                          else
                            return null;
                        },
                      ),
                      BlocBuilder<ProductsCategoryBloc, ProductsCategoryStates>(
                          builder: (_, state) {
                        print('rebuild');
                        if (state is InitialState ||
                            state is LoadingStateProductsCategory)
                          return Center(child: CircularProgressIndicator());
                        else if (state is LoadedStateProductsCategory)
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildProducts(deviceInfo),
                            ),
                          );
                        else if (state is ErrorStateProductsCategory)
                          return Center(
                            child: Text(
                                'Please Check from your internet connecation !!'),
                          );
                      })
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget buildProducts(DeviceInfo deviceInfo) {
    bool isSearch = searchBloc.searchedProducts.isEmpty;
    return BlocConsumer<CartBloc, CartStates>(
        listener: (_, state) {
          print('Inside Category products');
          isCategoryScreen = true;
          if (state is ErrorStateCart) {
            if (isCategoryScreen) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error in your internet connecation !!'),
                ),
              );
            }
          }
        },
        builder: (_, state) => GridView.builder(
              itemCount: isSearch
                  ? productsBloc.products.length
                  : searchBloc.searchedProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 10,
                childAspectRatio: 0.47,
              ),
              itemBuilder: (context, index) {
                return BuildProductItem(
                  deviceInfo: deviceInfo,
                  prodcut: isSearch
                      ? productsBloc.products[index]
                      : searchBloc.searchedProducts[index],
                );
              }),
        );
  }
}

class BuildProductItem extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final Product prodcut;
  BuildProductItem({this.deviceInfo, this.prodcut});

  @override
  _BuildProductItemState createState() => _BuildProductItemState();
}

class _BuildProductItemState extends State<BuildProductItem> {
  double fontSize = 0;
  CartBloc cartCubit;
  bool inCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    print('deactive mood');
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose mood');
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fontSize = getFontSizeVersion2(widget.deviceInfo);
    cartCubit = BlocProvider.of<CartBloc>(context);
    print(cartCubit.items.length);
    print('From start build\n');
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0, 2),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: buildProductImage(),
          ),
          Expanded(flex: 2, child: buildProductName()),
          Expanded(child: buildProductPrice()),
          Expanded(
            child: buildProductActions(),
          ),
        ],
      ),
    );
  }

  Widget buildProductActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BuildRawMaterialButton(
          icon: Icons.add,
          pressed: () async {
            cartCubit.add(
              AddingItemEvent(
                  cartItem: CartItem(
                    id: widget.prodcut.productId,
                    imageName: widget.prodcut.productImage,
                    nameAr: widget.prodcut.nameAr,
                    price: widget.prodcut.productPrice,
                    nameEn: widget.prodcut.nameEn,
                  ),
                  screenId: '1'),
            );
          },
          deviceInfo: widget.deviceInfo,
        ),
        Text(
          '${cartCubit.items.containsKey(widget.prodcut.productId) ? cartCubit.items[widget.prodcut.productId].quantity : 0}',
          style: TextStyle(fontSize: fontSize),
        ),
        BuildRawMaterialButton(
          icon: Icons.remove,
          pressed: () {
            cartCubit.add(
                DecreaseEvent(id: widget.prodcut.productId, screenId: '1'));
          },
          deviceInfo: widget.deviceInfo,
        ),
      ],
    );

    // return BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
    //   return
    // });
  }

  Widget buildProductPrice() {
    return BlocBuilder<CartBloc, CartStates>(
        builder: (_, state) => Text(
            '${cartCubit.items.containsKey(widget.prodcut.productId) ? (double.parse(cartCubit.items[widget.prodcut.productId].price) * double.parse(cartCubit.items[widget.prodcut.productId].quantity)).toStringAsFixed(2) : double.parse(widget.prodcut.productPrice).toStringAsFixed(2)}',
            style: TextStyle(fontSize: fontSize, color: Colors.green)));
  }

  Widget buildProductImage() {
    print(widget.prodcut.productImage);
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: TrimCachedImage(
        src: widget.prodcut.productImage,
      ),
    );
  }

  Widget buildProductName() {
    return Text(
      widget.prodcut.nameAr,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
  }
}
