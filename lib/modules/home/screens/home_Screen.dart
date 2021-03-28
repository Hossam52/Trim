import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../widgets/most_search_item.dart';
import '../../../widgets/trim_stars_item.dart';
import '../../../widgets/carousel_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedBottomIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CarouselSlider(
                items: [
                  CarouselItem(imagePath: 'assets/images/1.jpg'),
                  CarouselItem(imagePath: 'assets/images/2.jpg')
                ],
                options: CarouselOptions(aspectRatio: 2),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'الأكثر بحثا',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        MostSearchItem(imagePath: 'assets/images/1.jpg'),
                        MostSearchItem(imagePath: 'assets/images/2.jpg'),
                        MostSearchItem(imagePath: 'assets/images/3.jpg'),
                        MostSearchItem(imagePath: 'assets/images/4.jpg'),
                        MostSearchItem(imagePath: 'assets/images/5.jpg'),
                        MostSearchItem(imagePath: 'assets/images/6.jpg'),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'نجوم تريم',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(
                      children: [
                        TrimStarItem(
                            personImagePath: 'assets/images/person1.jpg',
                            name: 'Hossam'),
                        TrimStarItem(
                            personImagePath: 'assets/images/person2.jpg',
                            name: 'Ahmed Sayed'),
                        TrimStarItem(
                            personImagePath: 'assets/images/person3.jpg',
                            name: 'Salah'),
                        TrimStarItem(
                            personImagePath: 'assets/images/4.jpg',
                            name: 'Fady'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(
            Icons.location_pin,
            size: 40,
            color: Colors.blue,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 30,
          onTap: (int index) {
            setState(() {
              this._selectedBottomIndex = index;
            });
          },
          currentIndex: _selectedBottomIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(238, 243, 246, 1),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.face), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarms_sharp), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.adb), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_repair_service), label: ''),
          ],
        ),
      ),
    );
  }
}
