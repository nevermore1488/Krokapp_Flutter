import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';

class Place {
  final int id;
  final String title;
  final String logo;
  final double lat;
  final double lng;
  final bool isShowFavorite;
  final bool isFavorite;

  Place(
    this.id,
    this.title,
    this.logo, {
    this.lat = 0.0,
    this.lng = 0.0,
    this.isShowFavorite = false,
    this.isFavorite = false,
  });

  MarkerInfo toMarker() => MarkerInfo(id.toString(), title, LatLng(lat, lng));
}
