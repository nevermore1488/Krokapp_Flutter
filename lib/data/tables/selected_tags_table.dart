import 'package:krokapp_multiplatform/data/json_converter.dart';

class SelectedTagsTable {
  static const String TABLE_NAME = "selected_tags";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_TAG_ID INTEGER PRIMARY KEY'
      ')';

  static const String COLUMN_TAG_ID = "tag_id";

  int tagId = 0;

  SelectedTagsTable(this.tagId);

  SelectedTagsTable.fromJson(dynamic json) {
    tagId = json[COLUMN_TAG_ID];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_TAG_ID] = tagId;
    return map;
  }
}

class SelectedTagsJsonConverter extends JsonConverter<SelectedTagsTable> {
  @override
  SelectedTagsTable fromJson(Map<String, Object?> json) =>
      SelectedTagsTable.fromJson(json);

  @override
  Map<String, Object?> toJson(SelectedTagsTable pojo) => pojo.toJson();
}
