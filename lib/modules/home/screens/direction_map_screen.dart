import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart' as LocationManager;
import 'package:trim/modules/home/repositories/directions_repositry.dart';

class DirectionMapScreen extends StatefulWidget {
  static const String routeName = '/direction-map';
  @override
  _DirectionMapScreenState createState() => _DirectionMapScreenState();
}

class _DirectionMapScreenState extends State<DirectionMapScreen> {
  GoogleMapController _controller;
  BitmapDescriptor userLocationIcon;
  BitmapDescriptor marketLocationIcon;
  Set<Marker> markers = {};
  Directions info;
  List<LatLng> polyLineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                final directions = await DirectionRepositry().getDirections(
                    origin: markers.elementAt(0).position,
                    dest: markers.elementAt(1).position);
                setState(() {
                  info = directions;
                });
              },
              child: Text('Hello'))
        ],
      ),
      body: SafeArea(
        child: Container(
            height: double.infinity,
            child: GoogleMap(
              polylines: {
                if (info != null)
                  Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: info.polyLinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList()),
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(30.136685, 31.27448000000001), zoom: 15),
              onMapCreated: (controller) async {
                _controller = controller;
                await afterFirstLayout();
                setPolyLines();
              },
              zoomControlsEnabled: false,
              markers: markers,
            )),
      ),
    );
  }

  void setPolyLines() async {}

  Future<void> afterFirstLayout() async {
    await getBitmapDesciptiorFromAssetBytes('assets/icons/shop.png', 130)
        .then((value) => marketLocationIcon = value);
    await getBitmapDesciptiorFromAssetBytes('assets/icons/pin.png', 130)
        .then((value) => userLocationIcon = value);
    await getUserLocation().then((value) => setState(() {
          markers.add(Marker(
              markerId: MarkerId('1'),
              position: value,
              visible: true,
              icon: userLocationIcon));
        }));
    markers.add(Marker(
      markerId: MarkerId('2'),
      icon: marketLocationIcon,
      position: LatLng(30.142117352402693, 31.267987713217735),
      visible: true,
    ));
  }

  void fitCameraPosition(
      LatLng startCoordinates, LatLng destinationCoordinates) {
    LatLng _northeastCoordinates, _southwestCoordinates;
    if (startCoordinates.latitude <= destinationCoordinates.latitude) {
      _southwestCoordinates = startCoordinates;
      _northeastCoordinates = destinationCoordinates;
    } else {
      _southwestCoordinates = destinationCoordinates;
      _northeastCoordinates = startCoordinates;
    }
    _controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(
            _northeastCoordinates.latitude,
            _northeastCoordinates.longitude,
          ),
          southwest: LatLng(
            _southwestCoordinates.latitude,
            _southwestCoordinates.longitude,
          ),
        ),
        100.0, // padding
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String assetPath, int width) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo info = await codec.getNextFrame();
    return (await info.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDesciptiorFromAssetBytes(
      String assetPath, int width) async {
    final Uint8List imageData = await getBytesFromAsset(assetPath, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Future<void> initMarkerIcon(context) async {
    ImageConfiguration configuration = createLocalImageConfiguration(context);

    BitmapDescriptor.fromAssetImage(configuration, 'assets/icons/pin.png')
        .then((value) {
      setState(() {
        userLocationIcon = value;
      });
    });

    BitmapDescriptor.fromAssetImage(configuration, 'assets/icons/shop.png')
        .then((value) => marketLocationIcon = value);
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
}
