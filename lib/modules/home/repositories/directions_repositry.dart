import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionRepositry {
  static const _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionRepositry({Dio dio}) : _dio = dio ?? Dio();
  Future<Directions> getDirections(
      {@required LatLng origin, @required LatLng dest}) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${dest.latitude},${dest.longitude}',
      'key': 'AIzaSyC3QZTLUUQAxlik3D9MtzsxaHJG5Y75B8M'
    });
    //final response = await http.get(uri);
    if (response.statusCode == 200) {
      return Directions.fromJson(response.data);
    }
    return null;
  }
}

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polyLinePoints;
  final String totalDistance;
  final String totalDuration;

  Directions(
      {this.polyLinePoints,
      this.totalDistance,
      this.totalDuration,
      this.bounds});

  factory Directions.fromJson(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return null;
    final data = Map<String, dynamic>.from(map['routes'][0]);

    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
        northeast: LatLng(northeast['lat'], northeast['lng']),
        southwest: LatLng(southwest['lat'], southwest['lng']));
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
        bounds: bounds,
        polyLinePoints: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration);
  }
}
