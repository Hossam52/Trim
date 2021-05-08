import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/general_widgets/loading_more_items.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/widgets/barber_item.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/general_widgets/choice_button.dart';
import 'package:trim/modules/home/widgets/persons_grid_view.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/general_widgets/BuildAlertDialog.dart';
import 'package:trim/modules/home/widgets/BuildCitiesChoices.dart';
import 'package:trim/modules/home/widgets/BuildSalonItemGrid.dart';
import 'package:trim/general_widgets/BuildSearchWidget.dart';
import '../widgets/navigate_pages.dart';

class SalonsScreen extends StatefulWidget {
  static final String routeName = 'salonScreen';
  @override
  _SalonsScreenState createState() => _SalonsScreenState();
}

class _SalonsScreenState extends State<SalonsScreen> {
  String selectedCity = 'all';
  bool displaySalons = true;

  List<Salon> filterSalonsData = [];
  List<Salon> filterSalons(bool mostSearch) {
    if (mostSearch != null) //the screen show only most search salons
      filterSalonsData = mostSearchSalons
          .where((element) => element.cityEn == selectedCity)
          .toList();
    else // the screen show all salons
      filterSalonsData = salonsData
          .where((element) => element.cityEn == selectedCity)
          .toList();
    return filterSalonsData;
  }

  Future<void> showCities(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return BuildAlertDialog(
            child: BuildCitiesRadio(),
          );
        }).then((value) {
      if (value != null) //selected one
        selectedCity = value;

      print(value);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // if (temp != Temp.Home)
              if (state is AllSalonsState) buildSearchAndSettings(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceButton(
                      directionRoundedRight: false,
                      icon: hairIcon,
                      name: 'Salons',
                      active: displaySalons,
                      pressed: () {
                        if (!(HomeCubit.getInstance(context).state
                            is AllSalonsState))
                          HomeCubit.getInstance(context)
                              .emit(MostSearchState());
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
                        if (!(HomeCubit.getInstance(context).state
                            is AllSalonsState))
                          HomeCubit.getInstance(context).emit(TrimStarState());
                        // SalonsCubit.getInstance(context).emit(TrimStarState());
                        if (displaySalons)
                          setState(() {
                            displaySalons = false;
                          });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: Expanded(
                  child: displaySalons
                      ? BuildGridViewSalons(
                          selectedCity: selectedCity,
                        )
                      : PersonsGridView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildSearchAndSettings(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            await showCities(context);
          },
          child: Image.asset(
            'assets/icons/settings-icon.png',
            height: 25,
            width: 25,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: Colors.cyan, width: 1)),
            ),
          ),
        ),
        Expanded(
          child: BuildSearchWidget(
            pressed: () {},
            onChanged: (String val) {
              SalonsCubit.getInstance(context).searchSalonsByName(val);
            },
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    // bool displayAppBar = temp == Temp.Home ? true : false;
    bool displayAppBar = HomeCubit.getInstance(context).state is AllSalonsState;
    return !displayAppBar
        ? AppBar(
            backgroundColor: Colors.blue[800],
            title: BlocBuilder<HomeCubit, HomeStates>(
                builder: (_, state) => state is TrimStarState
                    ? Text('Trim Stars')
                    : Text('Most serch salons')),
            centerTitle: true,
          )
        : null;
  }
}

class BuildGridViewSalons extends StatefulWidget {
  const BuildGridViewSalons({
    @required this.selectedCity,
  });

  final String selectedCity;

  @override
  _BuildGridViewSalonsState createState() => _BuildGridViewSalonsState();
}

class _BuildGridViewSalonsState extends State<BuildGridViewSalons> {
  final gridViewController = ScrollController();
  @override
  void initState() {
    super.initState();
    gridViewController.addListener(() {
      if (gridViewController.position.pixels ==
          gridViewController.position.maxScrollExtent) {
        SalonsCubit.getInstance(context).loadMoreSalons(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    gridViewController.dispose();
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
            print('Build salon screen');
            if (state is LoadingSalonState)
              return Center(child: CircularProgressIndicator());
            if (state is ErrorSalonState)
              return Center(child: Text(state.error));
            final list =
                SalonsCubit.getInstance(context).getSalonsToDisplay(context);
            final pageNumber =
                SalonsCubit.getInstance(context).getCurrentPage(context);
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      controller: gridViewController,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: list.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.84,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) => BuildSalonItemGrid(
                            salon: list[index],
                          )),
                ),
                if (state is LoadingMoreSalonState) LoadingMoreItemsIndicator(),
                if (state is NoMoreSalonState)
                  NoMoreItems(
                    deviceInfo: deviceInfo,
                    label: 'No More Salons',
                  ),
                NavigatePages(
                  nextPage: SalonsCubit.getInstance(context).getNextPage,
                  pageNumber: pageNumber,
                  prevPage: SalonsCubit.getInstance(context).getPreviousPage,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
