import 'package:krokapp_multiplatform/data/pojo/lat_lng.dart';

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
