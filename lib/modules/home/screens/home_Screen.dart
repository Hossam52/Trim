import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int initialIndex = -1;
  final heightNavigationBar = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.grey[300],
        backgroundColor: Colors.white,
        items: [
          Image.asset('assets/icons/settings.png'),
          Image.asset('assets/icons/haircut.png'),
          Image.asset('assets/icons/location.png'),
          Image.asset('assets/icons/hair.png'),
          Image.asset('assets/icons/shop-icon.png'),
        ],
        onTap: (index) {
          setState(() {
            initialIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: selectedItem(initialIndex),
      ),
    );
  }

  Widget selectedItem(int index) {
    if (index == 0)
      return SettingsScreen();
    else if (index == 3) return SalonsScreen();
    return BuildHomeWidget(heightNavigationBar: heightNavigationBar);
  }
}

class BuildHomeWidget extends StatelessWidget {
  const BuildHomeWidget({
    Key key,
    @required this.heightNavigationBar,
  }) : super(key: key);

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BuildOffersWidgetItem(heightNavigationBar: heightNavigationBar),
            BuildButtonView(function: () {}, label: 'الأكثر بحثاً'),
            BuildMostSearchedSalons(heightNavigationBar: heightNavigationBar),
            BuildButtonView(function: () {}, label: 'نجوم تريم'),
            BuildStarsPersonsWidget(heightNavigationBar: heightNavigationBar),
          ],
        ),
      ),
    );
  }
}

class BuildStarsPersonsWidget extends StatelessWidget {
  const BuildStarsPersonsWidget({
    Key key,
    @required this.heightNavigationBar,
  }) : super(key: key);

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveFlutter.of(context).scale(200) - heightNavigationBar,
      child: ListView.builder(
        itemCount: 3,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => BuildStarPersonItem(),
      ),
    );
  }
}

class BuildStarPersonItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      width: MediaQuery.of(context).size.width / 3.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: Image.asset(
              'assets/images/barber.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ali ali',
                style: TextStyle(
                  fontSize: ResponsiveFlutter.of(context).fontSize(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Container(
                height: ResponsiveFlutter.of(context).scale(17),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: 5,
                    itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.all(2),
                          child: Image.asset(
                            'assets/icons/star.png',
                            fit: BoxFit.fill,
                          ),
                        )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class BuildMostSearchedSalons extends StatelessWidget {
  const BuildMostSearchedSalons({
    Key key,
    @required this.heightNavigationBar,
  }) : super(key: key);

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveFlutter.of(context).scale(280) - heightNavigationBar,
      padding: EdgeInsets.all(ResponsiveFlutter.of(context).scale(2)),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(3.0),
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 15,
          childAspectRatio: 2.1,
        ),
      ),
    );
  }
}

class BuildOffersWidgetItem extends StatelessWidget {
  const BuildOffersWidgetItem({
    Key key,
    @required this.heightNavigationBar,
  }) : super(key: key);

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveFlutter.of(context).scale(220) - heightNavigationBar,
      margin: EdgeInsets.symmetric(
          vertical: ResponsiveFlutter.of(context).scale(2)),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: CarouselSlider.builder(
        options: CarouselOptions(
            autoPlay: true, enlargeCenterPage: true, aspectRatio: 2.9),
        itemCount: 3,
        itemBuilder: (context, index, _) => BuildOffersItem(),
      ),
    );
  }
}

class BuildButtonView extends StatelessWidget {
  final Function function;
  final String label;
  BuildButtonView({this.function, this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: function, child: Text(label));
  }
}

class BuildOffersItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/images/barber.jpg',
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
      ),
      Positioned(
          bottom: 35,
          child: Container(
              padding: EdgeInsets.all(2),
              child: Text('عرض   50%   لفترة محدودة ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              height: ResponsiveFlutter.of(context).scale(30),
              decoration: BoxDecoration(
                color: Color(0xff676363).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ))),
    ]);
  }
}
