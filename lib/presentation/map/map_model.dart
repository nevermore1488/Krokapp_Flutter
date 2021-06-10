import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';

class MapModel {
  List<MarkerInfo> markers;
  List<LatLng> route;
  LatLng? currentLocation;
  LatLng? startLocation;

  MapModel({
    required this.markers,
    required this.route,
    this.currentLocation,
    this.startLocation,
  });
}
