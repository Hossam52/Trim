import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import 'package:location/location.dart' as LocationManager;

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

  Widget _buildMap() {
    return Expanded(
      flex: 3,
      child: GoogleMap(
        mapType: MapType.terrain,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(30.136685, 31.27448000000001),
          zoom: 15,
        ),
        markers: allMarkers,
        onTap: (pos) {
          print(allMarkers.length);
          Marker f = Marker(
              markerId: MarkerId(Random().nextInt(1000).toString()),
              icon: customIcon1,
              position: pos,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Clicked',
                  ),
                  duration: Duration(milliseconds: 100),
                ));
              });

          setState(() {
            allMarkers.add(f);
          });
        },
      ),
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

  @override
  Widget build(BuildContext context) {
    initMarkerIcon(context);
    return Scaffold(
        body: Container(
            child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        child: Column(
          children: [
            _buildMap(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: Text('Choose suitable appointment and service'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    _buildDateSelectionWidget(),
                    _buildTimeSelectionWidget(),
                    _buildButton()
                  ],
                ),
              ),
            ),
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
    salonsLocations.forEach((e) {
      Marker f = Marker(
          markerId: MarkerId(Random().nextInt(1000).toString()),
          icon: customIcon1,
          position: e,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Clicked',
              ),
              duration: Duration(milliseconds: 100),
            ));
          });

      allMarkers.add(f);
    });
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
