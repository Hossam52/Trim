import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';

import 'package:location/location.dart' as LocationManager;
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/home/widgets/BuildSalonItemGrid.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> allMarkers = <Marker>{};
  GoogleMapController mapController;
  BitmapDescriptor customIcon1;
  bool showSalonsWidget = true;
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();
  bool canLoadMap = false;
  String errorMessage = '';
  Position userPoition;
  bool loadData = true;

  LatLngBounds boundsFromLatLngList(Set<Marker> markers) {
    var lngs = markers.map<double>((m) => m.position.longitude).toList();
    var lats = markers.map<double>((m) => m.position.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }

  double getBoundsZoomLevel(LatLngBounds bounds, Size mapDimensions) {
    var worldDimension = Size(1024, 1024);

    double latRad(lat) {
      var sinValue = sin(lat * pi / 180);
      var radX2 = log((1 + sinValue) / (1 - sinValue)) / 2;
      return max(min(radX2, pi), -pi) / 2;
    }

    double zoom(mapPx, worldPx, fraction) {
      return (log(mapPx / worldPx / fraction) / ln2).floorToDouble();
    }

    var ne = bounds.northeast;
    var sw = bounds.southwest;

    var latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;

    var lngDiff = ne.longitude - sw.longitude;
    var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    var latZoom =
        zoom(mapDimensions.height, worldDimension.height, latFraction);
    var lngZoom = zoom(mapDimensions.width, worldDimension.width, lngFraction);

    if (latZoom < 0) return lngZoom;
    if (lngZoom < 0) return latZoom;

    return min(latZoom, lngZoom);
  }

  Widget _buildMap(double width, double height) {
    final bounds = boundsFromLatLngList(allMarkers);
    var zoomLevel = getBoundsZoomLevel(bounds, Size(width, height));
    return GoogleMap(
      mapType: MapType.terrain,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(userPoition.latitude, userPoition.longitude),
        zoom: zoomLevel,
      ),
      cameraTargetBounds: CameraTargetBounds(bounds),
      markers: allMarkers,
      onTap: (pos) {},
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
    List<Salon> mapSalons = [];
    return Scaffold(
        body: loadData
            ? TrimLoadingWidget()
            : !canLoadMap
                ? RetryWidget(
                    text: errorMessage,
                    onRetry: () {
                      setState(() {
                        loadData = true;
                        checkPermissionsAndLocationEnabled();
                      });
                    },
                  )
                : BlocBuilder<SalonsCubit, SalonStates>(
                    builder: (_, state) {
                      if (state is LoadingMapSalonState)
                        return TrimLoadingWidget();
                      else if (state is ErrorMapSalonState)
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(getWord('Error happened', context) +
                                  ': ${state.error}'),
                              TextButton(
                                  onPressed: () {
                                    //TO-DO
                                    SalonsCubit.getInstance(context)
                                        .loadNearestSalons(31, 31.5);
                                  },
                                  child: Text('Retry'))
                            ],
                          ),
                        );
                      List<Salon> nearestSalons =
                          SalonsCubit.getInstance(context).nearestSalons;
                      return Container(
                          child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: SafeArea(
                          child: Stack(
                            children: [
                              _buildMap(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 30),
                                  child: InfoWidget(
                                    responsiveWidget: (_, deviceInfo) =>
                                        showSalonsWidget == false
                                            ? actionButton(
                                                deviceInfo: deviceInfo,
                                                title: 'Show',
                                                icon: Icons.arrow_upward,
                                                whenPressed: true)
                                            : Container(
                                                height: deviceInfo.localHeight /
                                                    2.1,
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    actionButton(
                                                        deviceInfo: deviceInfo,
                                                        title: 'Hide',
                                                        icon: Icons
                                                            .arrow_downward,
                                                        whenPressed: false),
                                                    Expanded(
                                                      child: buildNearestSalons(
                                                          mapSalons,
                                                          deviceInfo,
                                                          nearestSalons),
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
                      ));
                    },
                  ));
  }

  Widget buildNearestSalons(
      List<Salon> mapSalons, DeviceInfo deviceInfo, List<Salon> nearestSalons) {
    return ScrollablePositionedList.builder(
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
      physics: BouncingScrollPhysics(),
      itemCount: nearestSalons.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, index) => Container(
        width: deviceInfo.localWidth / 2.5,
        child: BuildSalonItemGrid(salon: nearestSalons[index]),
      ),
    );
  }

  void checkPermissionsAndLocationEnabled() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    try {
      if (!serviceEnabled) {
        //Enable location from mbile
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw ('Location services are disabled enable it then retry.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          throw ('Location permissions are denied allow it then retry.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw ('Location permissions are permanently denied, we cannot request permissions allow it then retry.');
      }
      userPoition = await Geolocator.getCurrentPosition();
      setState(() {
        loadData = false;
        canLoadMap = true;
      });
    } catch (e) {
      setState(() {
        canLoadMap = false;
        loadData = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPermissionsAndLocationEnabled();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await initMarkerIcon(context);
      setState(() {
        makeUserLocationMarker();
        afterFirstLayout();
      });
    });
  }

  void afterFirstLayout() async {
    makeSalonsMarkers();
  }

  Future<void> makeUserLocationMarker() async {
    await getUserLocation().then((LatLng value) {
      setState(() {
        allMarkers.add(Marker(
            visible: true,
            markerId: MarkerId('user'),
            position: value,
            onTap: () {}));
      });
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void makeSalonsMarkers() async {
    List<Salon> mapSalons = SalonsCubit.getInstance(context).nearestSalons;
    final iconWidth = MediaQuery.of(context).size.width * 0.4;
    final markerIconBytes = await getBytesFromAsset(
        'assets/icons/map-scissor.png', iconWidth.ceil());

    for (int i = 0; i < mapSalons.length; i++) {
      Marker f = Marker(
          markerId: MarkerId(mapSalons[i].id.toString()),
          icon: BitmapDescriptor.fromBytes(markerIconBytes),
          position: LatLng(mapSalons[i].lat ?? 0, mapSalons[i].lang ?? 0),
          infoWindow: InfoWindow(title: mapSalons[i].name),
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
}
