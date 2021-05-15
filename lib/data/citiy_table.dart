import 'package:json_annotation/json_annotation.dart';

class CityTable {
  @JsonKey(name: 'id_locale')
  var uniqueId = 0;
  @JsonKey(name: 'id')
  var placeId = 0;
  var lang = 0;
  String logo;
  String name;
  var visible = true;
  var lat = 0.0;
  var lng = 0.0;

  CityTable(
    this.uniqueId,
    this.placeId,
    this.lang,
    this.logo,
    this.name,
    this.visible,
    this.lat,
    this.lng,
  );
}
