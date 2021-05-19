class PointTable {
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
  List<String> images = List.empty();
  List<int> tags = List.empty();
  bool isExcursion = false;

  PointTable(
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
    this.images,
    this.tags,
    this.isExcursion,
  );

  PointTable.fromJson(dynamic json) {
    uniqueId = json["id"];
    placeId = json["id_point"];
    name = json["name"];
    text = json["text"];
    sound = json["sound"];
    lang = json["lang"];
    lastEditTime = json["last_edit_time"];
    lat = json["lat"];
    lng = json["lng"];
    logo = json["logo"];
    photo = json["photo"];
    cityId = json["city_id"];
    visible = json["visible"];
    images = json["images"] != null ? json["images"].cast<String>() : [];
    tags = json["tags"] != null ? json["tags"].cast<int>() : [];
    isExcursion = json["is_excursion"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = uniqueId;
    map["id_point"] = placeId;
    map["name"] = name;
    map["text"] = text;
    map["sound"] = sound;
    map["lang"] = lang;
    map["last_edit_time"] = lastEditTime;
    map["lat"] = lat;
    map["lng"] = lng;
    map["logo"] = logo;
    map["photo"] = photo;
    map["city_id"] = cityId;
    map["visible"] = visible;
    map["images"] = images;
    map["tags"] = tags;
    map["is_excursion"] = isExcursion;
    return map;
  }
}
