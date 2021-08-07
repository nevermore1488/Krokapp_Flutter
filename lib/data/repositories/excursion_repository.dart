import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExcursionRepository {
  static const _EXCURSION_TIME_IN_MINUTES_KEY = "excursion_time_in_minutes";
  static const int _EXCURSION_DEFAULT_TIME_IN_MINUTES = 2 * 60 + 28;

  SharedPreferences _sharedPreferences;
  String _googleMapApiKey;

  late BehaviorSubject<int> _onExcursionTimeChangedController;

  ExcursionRepository(
    this._sharedPreferences,
    this._googleMapApiKey,
  ) {
    _onExcursionTimeChangedController =
        BehaviorSubject.seeded(getExcursionTimeInMinutes());
  }

  int getExcursionTimeInMinutes() {
    return _sharedPreferences.getInt(_EXCURSION_TIME_IN_MINUTES_KEY) ??
        _EXCURSION_DEFAULT_TIME_IN_MINUTES;
  }

  Stream<int> onExcursionTimeChanged() =>
      _onExcursionTimeChangedController.stream;

  Future<bool> setExcursionTime(int timeInMinutes) {
    _onExcursionTimeChangedController.add(timeInMinutes);
    return _sharedPreferences.setInt(
        _EXCURSION_TIME_IN_MINUTES_KEY, timeInMinutes);
  }

  Future<List<LatLng>> getRouteBetweenPoints(List<LatLng> points) async {
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
