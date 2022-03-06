import 'package:krokapp_multiplatform/data/pojo/lat_lng.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';

class Place {
  final PlaceType type;
  final int id;
  final String title;
  final String logo;
  final double lat;
  final double lng;
  bool isShowFavorite;
  bool isShowVisited;
  bool isFavorite;
  bool isVisited;

  Place(
    this.type,
    this.id,
    this.title,
    this.logo, {
    this.lat = 0.0,
    this.lng = 0.0,
    this.isShowFavorite = false,
    this.isShowVisited = false,
    this.isFavorite = false,
    this.isVisited = false,
  });

  LatLng getLatLng() => LatLng(lat, lng);

  MarkerInfo toMarker() => MarkerInfo(id.toString(), title, LatLng(lat, lng));
}

enum PlaceType { city, point }
