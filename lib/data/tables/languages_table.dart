import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';

class LanguagesTable {
  static const String TABLE_NAME = "languages";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_ID INTEGER PRIMARY KEY,'
      ' $COLUMN_KEY TEXT,'
      ' $COLUMN_NAME TEXT'
      ')';

  static const String COLUMN_ID = "id";
  static const String COLUMN_KEY = "key";
  static const String COLUMN_NAME = "name";

  int id = 0;
  String key = "";
  String name = "";

  LanguagesTable(this.id, this.key, this.name);

  LanguagesTable.fromJson(dynamic json) {
    id = json[COLUMN_ID];
    key = json[COLUMN_KEY];
    name = json[COLUMN_NAME];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[COLUMN_ID] = id;
    map[COLUMN_KEY] = key;
    map[COLUMN_NAME] = name;
    return map;
  }

  Language toLanguage() => Language(id: id, key: key, name: name);
}

class LanguagesJsonConverter extends JsonConverter<LanguagesTable> {
  @override
  LanguagesTable fromJson(Map<String, Object?> json) => LanguagesTable.fromJson(json);

  @override
  Map<String, Object?> toJson(LanguagesTable pojo) => pojo.toJson();
}

extension LanguagesStreamMaping on Stream<List<LanguagesTable>> {
  Stream<List<Language>> asLanguages() {
    return this.map((event) => event.map((e) => e.toLanguage()).toList());
  }
}
