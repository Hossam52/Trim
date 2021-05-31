import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/loading_more_items.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/person_states.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/widgets/barber_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/home/widgets/navigate_pages.dart';

class PersonsGridView extends StatefulWidget {
  final bool showFavoriteContainer;
  PersonsGridView({Key key, this.showFavoriteContainer = false});

  @override
  _PersonsGridViewState createState() => _PersonsGridViewState();
}

class _PersonsGridViewState extends State<PersonsGridView> {
  bool refresh = false;
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    final homeState = HomeCubit.getInstance(context).state;
    if (homeState is AllPersonsState) {
      if (PersonsCubit.getInstance(context).loadAllPersonsForFirstTime)
        PersonsCubit.getInstance(context)
            .loadAllPersons(context, refreshPage: true);
    } else if (homeState is TrimStarState) {
      if (PersonsCubit.getInstance(context).loadTrimStarsForFirstTime)
        PersonsCubit.getInstance(context)
            .loadAllPersons(context, refreshPage: true);
    } else if (homeState is FavoriteState) {
      if (PersonsCubit.getInstance(context).loadFavoritesForFirstTime)
        PersonsCubit.getInstance(context)
            .loadAllPersons(context, refreshPage: true);
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        PersonsCubit.getInstance(context).loadMorePersons(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => RefreshIndicator(
        onRefresh: () async {
          await PersonsCubit.getInstance(context)
              .loadAllPersons(context, refreshPage: true);
        },
        child: BlocConsumer<PersonsCubit, PersonStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            if (state is LoadingPersonsState)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (state is EmptyPersonListState)
              return Center(child: Text('No Salons available'));
            if (state is ErrorMorePersonState) {
              return RetryWidget(
                  text: state.error,
                  onRetry: () async {
                    await PersonsCubit.getInstance(context)
                        .loadAllPersons(context, refreshPage: false);
                  });
            }
            if (state is ErrorPersonsState) {
              return RetryWidget(
                  text: state.error,
                  onRetry: () async {
                    await PersonsCubit.getInstance(context)
                        .loadAllPersons(context, refreshPage: false);
                  });
            } else {
              var trimStarList =
                  PersonsCubit.getInstance(context).getPersonToDisplay(context);
              int pageNumber =
                  PersonsCubit.getInstance(context).getCurrentPage(context);
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: trimStarList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BarberItem(
                                showFavoriteContainer:
                                    widget.showFavoriteContainer,
                                personItem: trimStarList[index],
                                deviceInfo: deviceInfo));
                      },
                    ),
                  ),
                  if (state is LoadingMorePersonState)
                    LoadingMoreItemsIndicator(),
                  if (state is NoMorePersonState)
                    NoMoreItems(
                      deviceInfo: deviceInfo,
                      label: getWord('No More Salons', context),
                    ),
                  NavigatePages(
                    nextPage: PersonsCubit.getInstance(context).getNextPage,
                    pageNumber: pageNumber,
                    prevPage: PersonsCubit.getInstance(context).getPreviousPage,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
