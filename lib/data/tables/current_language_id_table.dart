import 'package:krokapp_multiplatform/data/json_converter.dart';

class CurrentLanguageIdTable {
  static const String TABLE_NAME = "current_language";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_ID INTEGER PRIMARY KEY'
      ')';

  static const String COLUMN_ID = "id";

  int id = 0;

  CurrentLanguageIdTable(this.id);

  CurrentLanguageIdTable.fromJson(dynamic json) {
    id = json[COLUMN_ID];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_ID] = id;
    return map;
  }
}

class CurrentLanguageIdJsonConverter extends JsonConverter<CurrentLanguageIdTable> {
  @override
  CurrentLanguageIdTable fromJson(Map<String, Object?> json) =>
      CurrentLanguageIdTable.fromJson(json);

  @override
  Map<String, Object?> toJson(CurrentLanguageIdTable pojo) => pojo.toJson();
}
