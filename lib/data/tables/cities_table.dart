import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';

class CitiesTable {
  static const String TABLE_NAME = "cities";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_UNIQUE_ID INTEGER PRIMARY KEY,'
      ' $COLUMN_PLACE_ID INTEGER,'
      ' $COLUMN_NAME TEXT,'
      ' $COLUMN_LANG INTEGER,'
      ' $COLUMN_LOGO TEXT,'
      ' $COLUMN_LAST_EDIT_TIME INTEGER,'
      ' $COLUMN_VISIBLE INTEGER'
      ')';

  static const String _API_UNIQUE_ID = "id_locale";
  static const String _API_PLACE_ID = "id";

  static const String COLUMN_UNIQUE_ID = "unique_id";
  static const String COLUMN_PLACE_ID = "place_id";

  static const String COLUMN_NAME = "name";
  static const String COLUMN_LANG = "lang";
  static const String COLUMN_LOGO = "logo";
  static const String COLUMN_LAST_EDIT_TIME = "last_edit_time";
  static const String COLUMN_VISIBLE = "visible";

  int uniqueId = 0;
  int placeId = 0;
  String name = "";
  int lang = 0;
  String logo = "";
  int lastEditTime = 0;
  bool visible = false;

  CitiesTable(
    this.uniqueId,
    this.placeId,
    this.name,
    this.lang,
    this.logo,
    this.lastEditTime,
    this.visible,
  );

  CitiesTable.fromJson(dynamic json, {isApi = false}) {
    uniqueId = json[isApi ? _API_UNIQUE_ID : COLUMN_UNIQUE_ID];
    placeId = json[isApi ? _API_PLACE_ID : COLUMN_PLACE_ID];

    name = json[COLUMN_NAME];
    lang = json[COLUMN_LANG];
    logo = json[COLUMN_LOGO];
    lastEditTime = json[COLUMN_LAST_EDIT_TIME];
    visible = isApi ? json[COLUMN_VISIBLE] : (json[COLUMN_VISIBLE] == 1);
  }

  Map<String, dynamic> toJson({isApi = false}) {
    var map = <String, dynamic>{};

    map[isApi ? _API_UNIQUE_ID : COLUMN_UNIQUE_ID] = uniqueId;
    map[isApi ? _API_PLACE_ID : COLUMN_PLACE_ID] = placeId;

    map[COLUMN_NAME] = name;
    map[COLUMN_LANG] = lang;
    map[COLUMN_LOGO] = logo;
    map[COLUMN_LAST_EDIT_TIME] = lastEditTime;
    map[COLUMN_VISIBLE] = isApi ? visible : (visible ? 1 : 0);

    return map;
  }

  Place toPlace() => Place(placeId, name, logo);
}

class CitiesJsonConverter extends JsonConverter<CitiesTable> {
  bool isApi;

  CitiesJsonConverter({this.isApi = false});

  @override
  CitiesTable fromJson(Map<String, Object?> json) => CitiesTable.fromJson(json, isApi: isApi);

  @override
  Map<String, Object?> toJson(CitiesTable pojo) => pojo.toJson(isApi: isApi);
}

extension CitiesStreamMaping on Stream<List<CitiesTable>> {
  Stream<List<Place>> asPlaces() {
    return this.map((event) => event.map((e) => e.toPlace()).toList());
  }
}
