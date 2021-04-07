import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/availableCities.dart';
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
          return BuildAlertDialog();
        }).then((value) {
      selectedCity = value;
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    pressed: () {},
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
                      itemBuilder: (context, index) => BuildItemGrid(
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

class BuildAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 24),
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Builder(
          builder: (context) => Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: BuildCitiesRadio(),
          ),
        ),
      ),
    );
  }
}

class BuildItemGrid extends StatelessWidget {
  final Salon salon;
  BuildItemGrid({this.salon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('pressed');
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/${salon.imagePath}.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FittedBox(
                      child: Container(
                        child: Text(
                          salon.salonName,
                          style: TextStyle(
                              color: Colors.cyan,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.9),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: ResponsiveFlutter.of(context).scale(14),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          padding: EdgeInsets.zero,
                          itemCount: salon.salonRate.toInt(),
                          itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.all(2),
                                child: Image.asset(
                                  'assets/icons/star.png',
                                  fit: BoxFit.fill,
                                ),
                              )),
                    ),
                    //Text('${salon.salonRate}',
                    // style: TextStyle(
                    //     color: Colors.cyan,
                    //     fontSize:
                    //         ResponsiveFlutter.of(context).fontSize(1.9),
                    //     fontWeight: FontWeight.bold)),
                    Text(
                      salon.salonStatus ? 'مفتوح الأن' : 'مغلق الأن',
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.9),
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildCitiesRadio extends StatefulWidget {
  @override
  _BuildCitiesRadioState createState() => _BuildCitiesRadioState();
}

class _BuildCitiesRadioState extends State<BuildCitiesRadio> {
  String selectedCity = availableCities[0];
  List<Widget> buildSelectedCity() {
    List<Widget> widgets = [];
    for (String city in availableCities) {
      widgets.add(
        ListTile(
          leading: Radio<String>(
            value: city,
            groupValue: selectedCity,
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          ),
          title: Text(city),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: buildSelectedCity(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: MaterialButton(
            onPressed: () {
              Navigator.pop(context, selectedCity);
            },
            child: Text(
              'ابحث الأن',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
