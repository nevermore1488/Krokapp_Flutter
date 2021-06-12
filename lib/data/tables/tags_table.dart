import 'package:krokapp_multiplatform/data/json_converter.dart';

class TagsTable {
  static const String TABLE_NAME = "tags";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_ID INTEGER PRIMARY KEY,'
      ' $COLUMN_TAG_ID INTEGER,'
      ' $COLUMN_LANG INTEGER,'
      ' $COLUMN_TAG_LABEL STRING'
      ')';

  static const String COLUMN_ID = "id";
  static const String COLUMN_TAG_ID = "tag_id";
  static const String COLUMN_LANG = "lang";
  static const String COLUMN_TAG_LABEL = "tag_label";

  int id = 0;
  int tagId = 0;
  int lang = 0;
  String tagLabel = "";

  TagsTable(
      this.id,
      this.tagId,
      this.lang,
      this.tagLabel,
      );

  TagsTable.fromJson(dynamic json) {
    id = json[COLUMN_ID];
    tagId = json[COLUMN_TAG_ID];
    lang = json[COLUMN_LANG];
    tagLabel = json[COLUMN_TAG_LABEL];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_ID] = id;
    map[COLUMN_TAG_ID] = tagId;
    map[COLUMN_LANG] = lang;
    map[COLUMN_TAG_LABEL] = tagLabel;
    return map;
  }
}

class TagsJsonConverter extends JsonConverter<TagsTable> {
  @override
  TagsTable fromJson(Map<String, Object?> json) => TagsTable.fromJson(json);

  @override
  Map<String, Object?> toJson(TagsTable pojo) => pojo.toJson();
}
