import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/widgets/BuildAlertDialog.dart';
import 'package:trim/widgets/BuildCitiesChoices.dart';
import 'package:trim/widgets/BuildSalonItemGrid.dart';
import 'package:trim/widgets/BuildSearchWidget.dart';

class SalonsScreen extends StatefulWidget {
  static final String routeName = 'salonScreen';
  @override
  _SalonsScreenState createState() => _SalonsScreenState();
}

class _SalonsScreenState extends State<SalonsScreen> {
  String selectedCity = 'all';
  List<Salon> filterSalonsData = [];
  List<Salon> filterSalons() {
    filterSalonsData = salonsData
        .where((element) => element.salonLocation == selectedCity)
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
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, bool>;
    bool hasBackButton = arguments != null ? arguments['hasBackButton'] : null;
    return Scaffold(
      appBar: hasBackButton != null
          ? AppBar(
              backgroundColor: Colors.blue[800],
              title: Text('All Salons'),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await showCities(context);
                      setState(() {
                        filterSalons();
                      });
                    },
                    child: Image.asset('assets/icons/settings-icon.png'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: Colors.cyan, width: 1)),
                      ),
                    ),
                  ),
                  BuildSearchWidget(
                    pressed: () {
                      print('search');
                    },
                  ),
                ],
              ),
              Container(
                child: Expanded(
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: selectedCity != 'all'
                          ? filterSalonsData.length
                          : salonsData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.84,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) => BuildSalonItemGrid(
                            salon: selectedCity != 'all'
                                ? filterSalonsData[index]
                                : salonsData[index],
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
