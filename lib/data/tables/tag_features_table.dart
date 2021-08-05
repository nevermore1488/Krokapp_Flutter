import 'package:krokapp_multiplatform/data/json_converter.dart';

class TagFeaturesTable {
  static const String TABLE_NAME = "tag_features";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_FEATURED_TAG_ID INTEGER PRIMARY KEY, '
      '$COLUMN_IS_CHECKED INTEGER'
      ')';

  static const String COLUMN_FEATURED_TAG_ID = "featured_tag_id";
  static const String COLUMN_IS_CHECKED = "is_checked";

  int tagId = 0;
  int isChecked = 0;

  TagFeaturesTable(
    this.tagId,
    this.isChecked,
  );

  TagFeaturesTable.fromJson(dynamic json) {
    tagId = json[COLUMN_FEATURED_TAG_ID] ?? 0;
    isChecked = json[COLUMN_IS_CHECKED] ?? 0;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_FEATURED_TAG_ID] = tagId;
    map[COLUMN_IS_CHECKED] = isChecked;
    return map;
  }
}

class TagFeaturesJsonConverter extends JsonConverter<TagFeaturesTable> {
  @override
  TagFeaturesTable fromJson(Map<String, Object?> json) =>
      TagFeaturesTable.fromJson(json);

  @override
  Map<String, Object?> toJson(TagFeaturesTable pojo) => pojo.toJson();
}
