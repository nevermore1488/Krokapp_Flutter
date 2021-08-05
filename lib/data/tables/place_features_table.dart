import 'package:krokapp_multiplatform/data/json_converter.dart';

class PlaceFeaturesTable {
  static const String TABLE_NAME = "place_features";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_FEATURED_PLACE_ID INTEGER PRIMARY KEY,'
      ' $COLUMN_IS_FAVORITE INTEGER,'
      ' $COLUMN_IS_VISITED INTEGER'
      ')';

  static const String COLUMN_FEATURED_PLACE_ID = "featured_place_id";
  static const String COLUMN_IS_FAVORITE = "is_favorite";
  static const String COLUMN_IS_VISITED = "is_visited";

  int featuredPlaceId = 0;
  int isFavorite = 0;
  int isVisited = 0;

  PlaceFeaturesTable(
    this.featuredPlaceId,
    this.isFavorite,
    this.isVisited,
  );

  PlaceFeaturesTable.fromJson(dynamic json) {
    featuredPlaceId = json[COLUMN_FEATURED_PLACE_ID] ?? 0;
    isFavorite = json[COLUMN_IS_FAVORITE] ?? 0;
    isVisited = json[COLUMN_IS_VISITED] ?? 0;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_FEATURED_PLACE_ID] = featuredPlaceId;
    map[COLUMN_IS_FAVORITE] = isFavorite;
    map[COLUMN_IS_VISITED] = isVisited;
    return map;
  }
}

class PlaceFeaturesJsonConverter extends JsonConverter<PlaceFeaturesTable> {
  @override
  PlaceFeaturesTable fromJson(Map<String, Object?> json) =>
      PlaceFeaturesTable.fromJson(json);

  @override
  Map<String, Object?> toJson(PlaceFeaturesTable pojo) => pojo.toJson();
}
