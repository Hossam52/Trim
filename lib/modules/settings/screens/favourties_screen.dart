import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/general_widgets/loading_more_items.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/general_widgets/choice_button.dart';
import 'package:trim/modules/settings/widgets/favorite_item.dart';
import 'package:trim/modules/home/widgets/persons_grid_view.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import '../../home/widgets/navigate_pages.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/favourite-screen';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  bool displaySalons = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Favorites'),
        centerTitle: true,
      ),
      body: InfoWidget(
        responsiveWidget: (context, deviceInfo) {
          final width = deviceInfo.localWidth;
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: buildSalonPersonsButtons(),
                ),
                Expanded(
                    child: displaySalons
                        ? BlocConsumer<SalonsCubit, SalonStates>(
                            listener: (oldState, newState) {},
                            builder: (_, state) {
                              if (state is LoadingSalonState)
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              else if (state is ErrorSalonState)
                                return Center(
                                    child:
                                        Text('Error ${state.error} happened'));

                              final favoriteList =
                                  SalonsCubit.getInstance(context)
                                      .getSalonsToDisplay(context);
                              final pageNumber =
                                  SalonsCubit.getInstance(context)
                                      .getCurrentPage(context);
                              return Column(
                                children: [
                                  Expanded(
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        await SalonsCubit.getInstance(context)
                                            .loadSalons(
                                                refreshPage: true,
                                                context: context);
                                      },
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: favoriteList.length,
                                          itemBuilder: (_, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: FavoriteItem(
                                                  favoriteSalon:
                                                      favoriteList[index],
                                                  deviceInfo: deviceInfo,
                                                  width: width),
                                            );
                                          }),
                                    ),
                                  ),
                                  if (state is LoadingMoreSalonState)
                                    LoadingMoreItemsIndicator(),
                                  if (state is NoMoreSalonState)
                                    NoMoreItems(
                                      deviceInfo: deviceInfo,
                                      label: 'No more Favorite salons',
                                    ),
                                  NavigatePages(
                                    pageNumber: pageNumber,
                                    nextPage: SalonsCubit.getInstance(context)
                                        .getNextPage,
                                    prevPage: SalonsCubit.getInstance(context)
                                        .getPreviousPage,
                                  )
                                ],
                              );
                            },
                          )
                        : PersonsGridView(
                            showFavoriteContainer: true,
                          )),
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildSalonPersonsButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceButton(
          directionRoundedRight: false,
          icon: hairIcon,
          name: 'Salons',
          active: displaySalons,
          pressed: () {
            if (!displaySalons)
              setState(() {
                displaySalons = true;
              });
          },
        ),
        ChoiceButton(
          directionRoundedRight: true,
          icon: marketIcon,
          name: 'Persons',
          active: !displaySalons,
          pressed: () {
            if (displaySalons)
              setState(() {
                displaySalons = false;
              });
          },
        ),
      ],
    );
  }
}
