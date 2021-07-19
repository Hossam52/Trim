import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/loading_more_items.dart';
import 'package:trim/general_widgets/no_data_widget.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/widgets/persons_grid_view.dart';
import 'package:trim/modules/home/widgets/salons_persons_widget.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/general_widgets/BuildAlertDialog.dart';
import 'package:trim/modules/home/widgets/BuildCitiesChoices.dart';
import 'package:trim/modules/home/widgets/BuildSalonItemGrid.dart';
import 'package:trim/general_widgets/BuildSearchWidget.dart';
import '../widgets/navigate_pages.dart';
import '../cubit/cities_cubit.dart';

class SalonsScreen extends StatefulWidget {
  static final String routeName = 'salonScreen';
  @override
  _SalonsScreenState createState() => _SalonsScreenState();
}

class _SalonsScreenState extends State<SalonsScreen> {
  bool displaySalons = true;

  List<Salon> filterSalonsData = [];

  Future<void> showCities(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return BuildAlertDialog(
            child: BlocProvider(
              create: (_) => CitiesCubit(),
              child: BuildCitiesRadio(),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final state = HomeCubit.getInstance(context).state;

    if (state is TrimStarState) {
      displaySalons = false;
    } else
      displaySalons = true;
  }

  @override
  Widget build(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;

    return Scaffold(
      appBar: appBar(context),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (state is AllSalonsState || state is AllPersonsState)
                buildSearchAndSettings(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: SalonsPersonsWidget(
                    displaySalons: displaySalons,
                    salonsPressed: () {
                      if (!displaySalons)
                        setState(() {
                          displaySalons = true;
                        });
                    },
                    personsPressed: () {
                      if (displaySalons)
                        setState(() {
                          displaySalons = false;
                        });
                    },
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child:
                      displaySalons ? BuildGridViewSalons() : PersonsGridView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSearchAndSettings(BuildContext context) {
    String getIntialText() {
      final state = HomeCubit.getInstance(context).state;
      if (state is AllSalonsState)
        return SalonsCubit.getInstance(context).searchName;
      else if (state is AllPersonsState)
        return PersonsCubit.getInstance(context).searchName;
      return '';
    }

    return Row(
      children: [
        InfoWidget(
          responsiveWidget: (_, deviceInfo) => ElevatedButton(
            onPressed: () async {
              await showCities(context);
            },
            child: Image.asset(
              'assets/icons/settings-icon.png',
              height: getFontSizeVersion2(deviceInfo),
              width: getFontSizeVersion2(deviceInfo),
              color: Theme.of(context).primaryColor,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
              ),
            ),
          ),
        ),
        Expanded(
          child: BuildSearchWidget(
            initialText: getIntialText(),
            onChanged: (String val) async {
              if (HomeCubit.getInstance(context).state is AllSalonsState)
                await SalonsCubit.getInstance(context)
                    .searchForSalon(name: val);
              else if (HomeCubit.getInstance(context).state is AllPersonsState)
                await PersonsCubit.getInstance(context)
                    .searchForPerson(name: val);
            },
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    final state = HomeCubit.getInstance(context).state;
    bool displayAppBar = state is AllSalonsState || state is AllPersonsState;
    return !displayAppBar
        ? AppBar(
            backgroundColor: Colors.blue[800],
            title: BlocBuilder<HomeCubit, HomeStates>(
                builder: (_, state) => state is TrimStarState
                    ? Text(getWord('Trim stars', context))
                    : Text(getWord('Most serch salons', context))),
            centerTitle: true,
          )
        : null;
  }
}

class BuildGridViewSalons extends StatefulWidget {
  const BuildGridViewSalons();

  @override
  _BuildGridViewSalonsState createState() => _BuildGridViewSalonsState();
}

class _BuildGridViewSalonsState extends State<BuildGridViewSalons> {
  @override
  void initState() {
    super.initState();
    final homeState = HomeCubit.getInstance(context).state;
    if (homeState is AllSalonsState) {
      if (SalonsCubit.getInstance(context).loadAllSalonsForFirstTime)
        SalonsCubit.getInstance(context)
            .loadSalons(refreshPage: true, context: context);
    } else if (homeState is MostSearchState) {
      if (SalonsCubit.getInstance(context).loadMostSearchSalonsForFirstTime)
        SalonsCubit.getInstance(context)
            .loadSalons(refreshPage: true, context: context);
    } else if (homeState is FavoriteState) {
      if (SalonsCubit.getInstance(context).loadFavoriteSalonsForFirstTime)
        SalonsCubit.getInstance(context)
            .loadSalons(refreshPage: true, context: context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => RefreshIndicator(
        onRefresh: () async {
          await SalonsCubit.getInstance(context)
              .loadSalons(refreshPage: true, context: context);
        },
        child: BlocConsumer<SalonsCubit, SalonStates>(
          buildWhen: (oldState, newState) {
            if (newState is LoadingSalonState ||
                newState is LoadedSalonState ||
                newState is ErrorSalonState ||
                newState is LoadingMoreSalonState ||
                newState is InitialSalonState ||
                newState is NoMoreSalonState ||
                newState is LoadingMoreSalonState ||
                newState is LoadedMoreSalonState)
              return true;
            else
              return false;
          },
          listener: (_, state) {
            if (state is ErrorSalonState)
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
          },
          builder: (_, state) {
            if (state is LoadingSalonState) return TrimLoadingWidget();
            if (state is ErrorSalonState)
              return RetryWidget(
                  text: state.error,
                  onRetry: () {
                    SalonsCubit.getInstance(context)
                        .loadSalons(refreshPage: false, context: context);
                  });
            final list =
                SalonsCubit.getInstance(context).getSalonsToDisplay(context);
            if (list.isEmpty) return EmptyDataWidget();
            final pageNumber =
                SalonsCubit.getInstance(context).getCurrentPage(context);
            return StaggeredGridView.countBuilder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: list.length + 1,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemBuilder: (_, index) {
                if (index == list.length) {
                  if (state is LoadingMoreSalonState)
                    return LoadingMoreItemsIndicator();
                  if (state is NoMoreSalonState)
                    return NoMoreItems(
                      deviceInfo: deviceInfo,
                      label: getWord('No More Salons', context),
                    );
                  return NavigatePages(
                    nextPage: SalonsCubit.getInstance(context).getNextPage,
                    pageNumber: pageNumber,
                    prevPage: SalonsCubit.getInstance(context).getPreviousPage,
                  );
                }
                return BuildSalonItemGrid(
                  salon: list[index],
                );
              },
              staggeredTileBuilder: (index) {
                if (index == list.length) {
                  //Last element put the navigatrion
                  return StaggeredTile.fit(2);
                }
                return StaggeredTile.count(1, 1 / 0.72);
              },
            );
          },
        ),
      ),
    );
  }
}
