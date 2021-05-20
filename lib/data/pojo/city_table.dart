const String CITIES_TABLE_NAME = "cities";

const String _UNIQUE_ID = "unique_id";
const String _PLACE_ID = "place_id";
const String _NAME = "name";
const String _LANG = "lang";
const String _LOGO = "logo";
const String _LAST_EDIT_TIME = "last_edit_time";
const String _VISIBLE = "visible";

const String _UNIQUE_ID_API = "id_locale";
const String _PLACE_ID_API = "id";

const String CITIES_TABLE_CREATE = 'CREATE TABLE $CITIES_TABLE_NAME('
    '$_UNIQUE_ID INTEGER PRIMARY KEY,'
    ' $_PLACE_ID INTEGER,'
    ' $_NAME TEXT,'
    ' $_LANG INTEGER,'
    ' $_LOGO TEXT,'
    ' $_LAST_EDIT_TIME INTEGER,'
    ' $_VISIBLE INTEGER'
    ')';

class CityTable {
  int uniqueId = 0;
  int placeId = 0;
  String name = "";
  int lang = 0;
  String logo = "";
  int lastEditTime = 0;
  bool visible = false;

  CityTable(
    this.uniqueId,
    this.placeId,
    this.name,
    this.lang,
    this.logo,
    this.lastEditTime,
    this.visible,
  );

  CityTable.fromJson(dynamic json, {isApi = false}) {
    String uniqueIdName = isApi ? _UNIQUE_ID_API : _UNIQUE_ID;
    String placeIdName = isApi ? _PLACE_ID_API : _PLACE_ID;
    uniqueId = json[uniqueIdName];
    placeId = json[placeIdName];
    name = json[_NAME];
    lang = json[_LANG];
    logo = json[_LOGO];
    lastEditTime = json[_LAST_EDIT_TIME];
    visible = isApi ? json[_VISIBLE] : (json[_VISIBLE] == 1);
  }

  Map<String, dynamic> toJson({isApi = false}) {
    String uniqueIdName = isApi ? _UNIQUE_ID_API : _UNIQUE_ID;
    String placeIdName = isApi ? _PLACE_ID_API : _PLACE_ID;
    var map = <String, dynamic>{};
    map[uniqueIdName] = uniqueId;
    map[placeIdName] = placeId;
    map[_NAME] = name;
    map[_LANG] = lang;
    map[_LOGO] = logo;
    map[_LAST_EDIT_TIME] = lastEditTime;
    map[_VISIBLE] = isApi ? visible : (visible ? 1 : 0);
    return map;
  }
}
