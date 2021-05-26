import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerInfo {
  final String id;
  final String title;
  final LatLng latLng;

  MarkerInfo(
    this.id,
    this.title,
    this.latLng,
  );
}
