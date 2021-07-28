import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/general_widgets/loading_more_items.dart';
import 'package:trim/general_widgets/no_data_widget.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/widgets/salons_persons_widget.dart';
import 'package:trim/modules/settings/widgets/favorite_item.dart';
import 'package:trim/modules/home/widgets/persons_grid_view.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
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
    SalonsCubit.getInstance(context)
        .loadSalons(refreshPage: false, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(translatedWord('my favorites', context)),
        centerTitle: true,
      ),
      body: ResponsiveWidget(
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
                  child: SalonsPersonsWidget(
                    displaySalons: displaySalons,
                    personsPressed: () {
                      if (displaySalons)
                        setState(() {
                          displaySalons = false;
                        });
                    },
                    salonsPressed: () {
                      if (!displaySalons)
                        setState(() {
                          displaySalons = true;
                        });
                    },
                  ),
                ),
                Expanded(
                  child: displaySalons
                      ? BlocConsumer<SalonsCubit, SalonStates>(
                          listener: (oldState, newState) {},
                          builder: (_, state) {
                            if (state is LoadingSalonState)
                              return TrimLoadingWidget();
                            else if (state is ErrorSalonState)
                              return RetryWidget(
                                  text: state.error,
                                  onRetry: () {
                                    SalonsCubit.getInstance(context)
                                        .loadFavoriteSalons(refreshPage: true);
                                  });

                            final favoriteList =
                                SalonsCubit.getInstance(context)
                                    .getSalonsToDisplay(context);
                            if (favoriteList.isEmpty) return EmptyDataWidget();
                            final pageNumber = SalonsCubit.getInstance(context)
                                .getCurrentPage(context);
                            return RefreshIndicator(
                              onRefresh: () async {
                                await SalonsCubit.getInstance(context)
                                    .loadSalons(
                                        refreshPage: true, context: context);
                              },
                              child: displayFavorites(favoriteList, state,
                                  pageNumber, deviceInfo, width),
                            );
                          },
                        )
                      : PersonsGridView(
                          showFavoriteContainer: true,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget displayFavorites(List favoriteList, SalonStates state, int pageNumber,
      DeviceInfo deviceInfo, double width) {
    return StaggeredGridView.countBuilder(
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        itemCount: favoriteList.length + 1,
        itemBuilder: (_, index) {
          if (index == favoriteList.length) {
            if (state is LoadingMoreSalonState)
              return LoadingMoreItemsIndicator();
            if (state is NoMoreSalonState)
              return NoMoreItems(
                deviceInfo: deviceInfo,
                label: translatedWord('No More Salons', context),
              );
            return NavigatePages(
              pageNumber: pageNumber,
              nextPage: SalonsCubit.getInstance(context).getNextPage,
              prevPage: SalonsCubit.getInstance(context).getPreviousPage,
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FavoriteItem(
                favoriteSalon: favoriteList[index],
                deviceInfo: deviceInfo,
                width: width),
          );
        },
        staggeredTileBuilder: (index) {
          if (index == favoriteList.length) return StaggeredTile.fit(1);
          return StaggeredTile.count(1, 0.45);
        });
  }
}
