import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleMapRepository {

  String _googleMapApiKey;

  GoogleMapRepository(
    this._googleMapApiKey,
  );

  Future<List<LatLng>> buildRouteBetweenPoints(List<LatLng> points) async {
    var polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      _googleMapApiKey, // Google Maps API Key
      PointLatLng(points[0].latitude, points[0].longitude),
      PointLatLng(points.last.latitude, points.last.longitude),
      wayPoints: points
          .getRange(1, points.length - 1)
          .map((e) => PolylineWayPoint(
                location: "${e.latitude},${e.longitude}",
              ))
          .toList(),
      travelMode: TravelMode.walking,
    );

    return result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }
}
