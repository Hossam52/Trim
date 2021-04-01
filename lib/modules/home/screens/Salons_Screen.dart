import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/models/Salon.dart';

class SalonsScreen extends StatefulWidget {
  static final String routeName = 'salonScreen';
  @override
  _SalonsScreenState createState() => _SalonsScreenState();
}

class _SalonsScreenState extends State<SalonsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BuildSearchWidget(),
              Container(
                child: Expanded(
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: salonsData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.84,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) => BuildItemGrid(
                            salon: salonsData[index],
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

class BuildSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Image.asset('assets/icons/settings-icon.png'),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: Colors.cyan, width: 1)))),
        ),
        Expanded(
            child: Form(
                child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          height: ResponsiveFlutter.of(context).scale(40),
          child: TextFormField(
            decoration: InputDecoration(
                hintText: 'ابحث عن',
                prefixIcon: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.cyan),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))))),
                fillColor: Colors.grey[200],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                )),
          ),
        ))),
      ],
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
      child: Container(
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
                    Text('${salon.salonRate}',
                        style: TextStyle(
                            color: Colors.cyan,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.9),
                            fontWeight: FontWeight.bold)),
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
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                offset: Offset(0, 2),
              )
            ]),
      ),
    );
  }
}
