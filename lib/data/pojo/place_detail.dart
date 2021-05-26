import 'package:krokapp_multiplatform/data/pojo/place.dart';

class PlaceDetail extends Place {
  final String text;
  final String sound;
  final List<int> tags;
  final List<String> images;

  PlaceDetail(
    int id,
    String title,
    String logo,
    this.text,
    this.sound,
    this.tags,
    this.images, {
    double lat = 0.0,
    double lng = 0.0,
    bool isShowFavorite = false,
    bool isFavorite = false,
  }) : super(
          id,
          title,
          logo,
          lat: lat,
          lng: lng,
          isShowFavorite: isShowFavorite,
          isFavorite: isFavorite,
        );
}
