import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/cubit/home_states.dart';
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

class SalonsScreen extends StatefulWidget {
  static final String routeName = 'salonScreen';
  @override
  _SalonsScreenState createState() => _SalonsScreenState();
}

class _SalonsScreenState extends State<SalonsScreen> {
  bool mostSearch;
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
    DisplayType displayType = HomeCubit.getInstance(context).getDisplayType;

    if (displayType == DisplayType.AllSalons ||
        displayType == DisplayType.MostSearch) {
      displaySalons = true;
    } else
      displaySalons = false;
    mostSearch = displayType == DisplayType.MostSearch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              buildSearchAndSettings(context),
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
                        if (!displaySalons)
                          setState(() {
                            displaySalons = true;
                            filterSalons(mostSearch);
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
                ),
              ),
              Container(
                child: Expanded(
                  child: displaySalons
                      ? BuildGridViewSalons(
                          selectedCity: selectedCity,
                          filterSalonsData: filterSalonsData,
                          mostSearch: mostSearch)
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
            setState(() {
              filterSalons(mostSearch);
            });
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
          ),
        ),
      ],
    );
  }

  AppBar appBar() {
    return mostSearch
        ? AppBar(
            backgroundColor: Colors.blue[800],
            title: Text('Most serch salons'),
            centerTitle: true,
          )
        : null;
  }
}

class BuildGridViewSalons extends StatelessWidget {
  const BuildGridViewSalons({
    @required this.selectedCity,
    @required this.filterSalonsData,
    @required this.mostSearch,
  });

  final String selectedCity;
  final List<Salon> filterSalonsData;
  final bool mostSearch;

  @override
  Widget build(BuildContext context) {
    final list = HomeCubit.getInstance(context).mostSearchList;
    return GridView.builder(
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
            ));
  }
}
