import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart'
    show BuildItemGrid;
import 'package:intl/intl.dart';

import 'package:location/location.dart' as LocationManager;
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> allMarkers = <Marker>{};
  GoogleMapController mapController;
  BitmapDescriptor customIcon1;
  DateTime _selectedDate = DateTime.now();
  String _time;
  bool correctData = true;
  bool showSalonsWidget = true;
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  Widget _buildMap() {
    return GoogleMap(
      mapType: MapType.terrain,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(30.136685, 31.27448000000001),
        zoom: 15,
      ),
      markers: allMarkers,
      onTap: (pos) {},
    );
  }

  Widget _buildDateSelectionWidget() {
    return Expanded(
      child: InkWell(
          onTap: () {
            datePickerDialog();
          },
          child: FittedBox(
              child: Text(DateFormat('EEE d/M/y').format(_selectedDate)))),
    );
  }

  Widget _buildTimeSelectionWidget() {
    return Expanded(
      child: InkWell(
        onTap: () {
          timePickerDialog();
        },
        child: FittedBox(
          child: Text('Time ${_time ?? "_ _ : _ _"}'),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Expanded(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
          child: FittedBox(child: Text('Select service')),
          onPressed: () {
            if (_time == null)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Enter date and time correctly'),
                ),
              );
          }),
    );
  }

  Widget actionButton(
      {DeviceInfo deviceInfo, String title, IconData icon, bool whenPressed}) {
    return Container(
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            showSalonsWidget = whenPressed;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        label: Text(title, style: TextStyle(fontSize: getFontSize(deviceInfo))),
        icon: Icon(icon, size: getFontSize(deviceInfo)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    initMarkerIcon(context);
    return Scaffold(
        body: Container(
            child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Stack(
          children: [
            _buildMap(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: InfoWidget(
                  responsiveWidget: (_, deviceInfo) => showSalonsWidget == false
                      ? actionButton(
                          deviceInfo: deviceInfo,
                          title: 'Show',
                          icon: Icons.arrow_upward,
                          whenPressed: true)
                      : Container(
                          height: deviceInfo.localHeight / 2.1,
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              actionButton(
                                  deviceInfo: deviceInfo,
                                  title: 'Hide',
                                  icon: Icons.arrow_downward,
                                  whenPressed: false),
                              Expanded(
                                child: ScrollablePositionedList.builder(
                                  itemScrollController: itemScrollController,
                                  itemPositionsListener: itemPositionsListener,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: mapSalons.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) => Container(
                                    width: deviceInfo.localWidth / 2.5,
                                    child:
                                        BuildItemGrid(salon: mapSalons[index]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    )));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initMarkerIcon(context);
      setState(() {
        afterFirstLayout();
      });
      // temp();
    });
  }

  void afterFirstLayout() async {
    List<LatLng> salonsLocations = [
      LatLng(30.133912262634386, 31.273745745420456),
      LatLng(30.132346728940966, 31.274213790893555),
      LatLng(30.130133075858343, 31.273340061306953),
      LatLng(30.135126338811588, 31.268736720085144),
      LatLng(30.130025204672926, 31.268970742821693),
      LatLng(30.138406328553632, 31.278630048036575),
      LatLng(30.13260277180459, 31.278349086642265),
      LatLng(30.128419301957575, 31.277475357055664),
      LatLng(30.139566419055328, 31.272169947624207),
      LatLng(30.142036168906582, 31.275899559259415),
    ];
    //await makeUserLocationMarker();
    makeSalonsMarkers(salonsLocations);
  }

  Future<void> makeUserLocationMarker() async {
    await getUserLocation().then((value) {
      setState(() {
        allMarkers.add(Marker(
            visible: true,
            markerId: MarkerId('1'),
            position: value,
            onTap: () {}));
      });
    });
  }

  void makeSalonsMarkers(List<LatLng> salonsLocations) {
    for (int i = 0; i < mapSalons.length; i++) {
      Marker f = Marker(
          markerId: MarkerId(Random().nextInt(1000).toString()),
          icon: customIcon1,
          position: mapSalons[i].latLng,
          infoWindow: InfoWindow(title: mapSalons[i].salonName),
          onTap: () {
            if (showSalonsWidget)
              itemScrollController.scrollTo(
                  index: i,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic);
          });

      allMarkers.add(f);
    }
  }

  Future<void> initMarkerIcon(context) async {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/icons/map-scissor.png')
          .then((value) {
        print(value);
        setState(() {
          customIcon1 = value;
        });
      });
    }
  }

  Future<LatLng> getUserLocation() async {
    LocationManager.LocationData currentLocation;
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void datePickerDialog() async {
    await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 30),
      ),
    ).then((value) => setState(() {
          _selectedDate = value ?? _selectedDate;
        }));
  }

  void timePickerDialog() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 09, minute: 00),
            initialEntryMode: TimePickerEntryMode.input)
        .then((value) {
      if (value != null)
        setState(() {
          String hours = value.hour.toString().padLeft(2, '0');
          String minutes = value.minute.toString().padLeft(2, '0');
          _time = hours + " : " + minutes;
        });
    });
  }
}
