import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = 'homeScreen';
  final bottomNavigationBar = CurvedNavigationBar(
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
      print(index);
    },
  );
  final heightNavigationBar = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: ResponsiveFlutter.of(context).scale(220) -
                      heightNavigationBar,
                  margin: EdgeInsets.symmetric(
                      vertical: ResponsiveFlutter.of(context).scale(2)),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.9),
                    itemCount: 3,
                    itemBuilder: (context, index, _) => BuildOffersItem(),
                  ),
                ),
                BuildButtonView(function: () {}, label: 'الأكثر بحثاً'),
                Container(
                  height: ResponsiveFlutter.of(context).scale(266) -
                      heightNavigationBar,
                  padding:
                      EdgeInsets.all(ResponsiveFlutter.of(context).scale(2)),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 15),
                  ),
                ),
                BuildButtonView(function: () {}, label: 'نجوم تريم'),
                Container(
                  height: ResponsiveFlutter.of(context).scale(200) -
                      heightNavigationBar,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 3,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.asset(
                                'assets/images/barber.jpg',
                                height:
                                    ResponsiveFlutter.of(context).scale(130) -
                                        heightNavigationBar,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ali ali',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Container(
                                    height:
                                        ResponsiveFlutter.of(context).scale(17),
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemCount: 5,
                                        itemBuilder: (context, index) =>
                                            Container(
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
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.70,
                        crossAxisSpacing: 10,
                        crossAxisCount: 3),
                  ),
                ),
              ],
            ),
          ),
        ),
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
