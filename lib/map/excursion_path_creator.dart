import 'dart:math';

import 'package:krokapp_multiplatform/data/pojo/lat_lng.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';

class ExcursionPathCreator {
  List<Place> createPath(
    double powerLatLng,
    LatLng yourLocation,
    List<Place> points,
  ) {
    final pointsNear = List<Place>.of(points);
    var currentRoute = List<Place>.empty(growable: true);
    var currentPower = powerLatLng;

    var currentLocation = yourLocation;

    while (currentPower >= 0 && pointsNear.isNotEmpty) {
      var nextPoint = pointsNear.reduce((value, element) =>
          _distanceBetween(value.getLatLng(), currentLocation) <
                  _distanceBetween(element.getLatLng(), currentLocation)
              ? value
              : element);

      pointsNear.remove(nextPoint);

      var distanceLost = _distanceBetween(
        currentLocation,
        nextPoint.getLatLng(),
      );

      currentPower -= distanceLost;

      if (currentPower >= 0) {
        currentRoute.add(nextPoint);
      }
    }

    return currentRoute;
  }

  double _distanceBetween(LatLng p1, LatLng p2) {
    var latSquareDiff = pow((p1.lat - p2.lat).abs(), 2.0);
    var lngSquareDiff = pow((p1.lng - p2.lng).abs(), 2.0);
    return sqrt(latSquareDiff + lngSquareDiff);
  }
}
