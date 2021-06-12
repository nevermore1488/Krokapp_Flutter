import 'package:krokapp_multiplatform/data/json_converter.dart';

class TagsOfPlacesTable {
  static const String TABLE_NAME = "tags_of_places";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $COLUMN_TAG_ID INTEGER,'
      ' $COLUMN_PLACE_ID INTEGER'
      ')';

  static const String COLUMN_ID = "id";
  static const String COLUMN_TAG_ID = "tag_id";
  static const String COLUMN_PLACE_ID = "place_id";

  int tagId = 0;
  int placeId = 0;

  TagsOfPlacesTable(
      this.tagId,
      this.placeId,
      );

  TagsOfPlacesTable.fromJson(dynamic json) {
    tagId = json[COLUMN_TAG_ID];
    placeId = json[COLUMN_PLACE_ID];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_TAG_ID] = tagId;
    map[COLUMN_PLACE_ID] = placeId;
    return map;
  }
}

class TagsOfPlacesJsonConverter extends JsonConverter<TagsOfPlacesTable> {
  @override
  TagsOfPlacesTable fromJson(Map<String, Object?> json) => TagsOfPlacesTable.fromJson(json);

  @override
  Map<String, Object?> toJson(TagsOfPlacesTable pojo) => pojo.toJson();
}
