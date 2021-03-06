import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';

class PointsTable {
  static const String TABLE_NAME = "points";

  static const String CREATE_TABLE_CLAUSE = 'CREATE TABLE $TABLE_NAME('
      '$COLUMN_UNIQUE_ID INTEGER PRIMARY KEY,'
      ' $COLUMN_PLACE_ID INTEGER,'
      ' $COLUMN_NAME TEXT,'
      ' $COLUMN_TEXT TEXT,'
      ' $COLUMN_SOUND TEXT,'
      ' $COLUMN_LANG INTEGER,'
      ' $COLUMN_LAST_EDIT_TIME INTEGER,'
      ' $COLUMN_LAT REAL,'
      ' $COLUMN_LNG REAL,'
      ' $COLUMN_LOGO TEXT,'
      ' $COLUMN_PHOTO TEXT,'
      ' $COLUMN_CITY_ID INTEGER,'
      ' $COLUMN_VISIBLE INTEGER,'
      ' $COLUMN_IS_EXCURSION INTEGER,'
      ' $COLUMN_IMAGES TEXT'
      ')';

  static const String _API_UNIQUE_ID = "id";
  static const String _API_PLACE_ID = "id_point";

  static const String COLUMN_UNIQUE_ID = "unique_id";
  static const String COLUMN_PLACE_ID = "place_id";

  static const String COLUMN_NAME = "name";
  static const String COLUMN_TEXT = "text";
  static const String COLUMN_SOUND = "sound";
  static const String COLUMN_LANG = "lang";
  static const String COLUMN_LAST_EDIT_TIME = "last_edit_time";
  static const String COLUMN_LAT = "lat";
  static const String COLUMN_LNG = "lng";
  static const String COLUMN_LOGO = "logo";
  static const String COLUMN_PHOTO = "photo";
  static const String COLUMN_CITY_ID = "city_id";
  static const String COLUMN_VISIBLE = "visible";
  static const String COLUMN_IS_EXCURSION = "is_excursion";
  static const String COLUMN_IMAGES = "images";

  static const String _API_ONLY_TAGS = "tags";

  int uniqueId = 0;
  int placeId = 0;
  String name = "";
  String text = "";
  String sound = "";
  int lang = 0;
  int lastEditTime = 0;
  double lat = 0;
  double lng = 0;
  String logo = "";
  String photo = "";
  int cityId = 0;
  bool visible = false;
  bool isExcursion = false;

  List<int> tags = List.empty();
  List<String> images = List.empty();

  PointsTable(
    this.uniqueId,
    this.placeId,
    this.name,
    this.text,
    this.sound,
    this.lang,
    this.lastEditTime,
    this.lat,
    this.lng,
    this.logo,
    this.photo,
    this.cityId,
    this.visible,
    this.isExcursion,
    this.tags,
    this.images,
  );

  PointsTable.fromJson(dynamic json, {isApi = false}) {
    uniqueId = json[isApi ? _API_UNIQUE_ID : COLUMN_UNIQUE_ID];
    placeId = json[isApi ? _API_PLACE_ID : COLUMN_PLACE_ID];

    name = json[COLUMN_NAME];
    text = json[COLUMN_TEXT];
    sound = json[COLUMN_SOUND];
    lang = json[COLUMN_LANG];
    lastEditTime = json[COLUMN_LAST_EDIT_TIME];
    lat = json[COLUMN_LAT];
    lng = json[COLUMN_LNG];
    logo = json[COLUMN_LOGO];
    photo = json[COLUMN_PHOTO];
    cityId = json[COLUMN_CITY_ID];
    visible = isApi ? json[COLUMN_VISIBLE] : (json[COLUMN_VISIBLE] == 1);

    if(json[COLUMN_IS_EXCURSION] != null) {
      isExcursion =
      isApi ? json[COLUMN_IS_EXCURSION] : (json[COLUMN_IS_EXCURSION] == 1);
    } else {
      isExcursion = true;
    }

    tags = json[_API_ONLY_TAGS] != null ? json[_API_ONLY_TAGS].cast<int>() : [];
    images = isApi
        ? (json[COLUMN_IMAGES] != null
            ? json[COLUMN_IMAGES].cast<String>()
            : [])
        : (json[COLUMN_IMAGES] as String)
            .split(',')
            .where((element) => element.isNotEmpty)
            .toList();
  }

  Map<String, dynamic> toJson({isApi = false}) {
    var map = <String, dynamic>{};

    map[isApi ? _API_UNIQUE_ID : COLUMN_UNIQUE_ID] = uniqueId;
    map[isApi ? _API_PLACE_ID : COLUMN_PLACE_ID] = placeId;

    map[COLUMN_NAME] = name;
    map[COLUMN_TEXT] = text;
    map[COLUMN_SOUND] = sound;
    map[COLUMN_LANG] = lang;
    map[COLUMN_LAST_EDIT_TIME] = lastEditTime;
    map[COLUMN_LAT] = lat;
    map[COLUMN_LNG] = lng;
    map[COLUMN_LOGO] = logo;
    map[COLUMN_PHOTO] = photo;
    map[COLUMN_CITY_ID] = cityId;
    map[COLUMN_VISIBLE] = isApi ? visible : (visible ? 1 : 0);
    map[COLUMN_IS_EXCURSION] = isApi ? isExcursion : (isExcursion ? 1 : 0);

    if (isApi) {
      map[_API_ONLY_TAGS] = tags;
    }

    map[COLUMN_IMAGES] = isApi ? images : images.join(',');

    return map;
  }

  Place toPlace() => toPlaceDetail();

  PlaceDetail toPlaceDetail() => PlaceDetail(
        PlaceType.point,
        placeId,
        name,
        logo,
        text,
        sound,
        tags,
        images,
        lat: lat,
        lng: lng,
      );
}

class PointsJsonConverter extends JsonConverter<PointsTable> {
  bool isApi;

  PointsJsonConverter({this.isApi = false});

  @override
  PointsTable fromJson(Map<String, Object?> json) =>
      PointsTable.fromJson(json, isApi: isApi);

  @override
  Map<String, Object?> toJson(PointsTable pojo) => pojo.toJson(isApi: isApi);
}

extension PointsStreamMaping on Stream<List<PointsTable>> {
  Stream<List<PlaceDetail>> asPlaceDetails() =>
      this.map((event) => event.map((e) => e.toPlaceDetail()).toList());

  Stream<List<Place>> asPlaces() => this.asPlaceDetails();
}
