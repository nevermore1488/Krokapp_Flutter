import 'package:krokapp_multiplatform/data/json_converter.dart';

class FeaturesTable {
  static const String TABLE_NAME = "Features";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_PLACE_ID INTEGER PRIMARY KEY,'
      ' $COLUMN_IS_FAVORITE INTEGER,'
      ' $COLUMN_IS_VISITED INTEGER'
      ')';

  static const String COLUMN_PLACE_ID = "featured_place_id";
  static const String COLUMN_IS_FAVORITE = "is_favorite";
  static const String COLUMN_IS_VISITED = "is_visited";

  int placeId = 0;
  int isFavorite = 0;
  int isVisited = 0;

  FeaturesTable(
    this.placeId,
    this.isFavorite,
    this.isVisited,
  );

  FeaturesTable.fromJson(dynamic json) {
    placeId = json[COLUMN_PLACE_ID] ?? 0;
    isFavorite = json[COLUMN_IS_FAVORITE] ?? 0;
    isVisited = json[COLUMN_IS_VISITED] ?? 0;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_PLACE_ID] = placeId;
    map[COLUMN_IS_FAVORITE] = isFavorite;
    map[COLUMN_IS_VISITED] = isVisited;
    return map;
  }
}

class FeaturesJsonConverter extends JsonConverter<FeaturesTable> {
  @override
  FeaturesTable fromJson(Map<String, Object?> json) => FeaturesTable.fromJson(json);

  @override
  Map<String, Object?> toJson(FeaturesTable pojo) => pojo.toJson();
}
