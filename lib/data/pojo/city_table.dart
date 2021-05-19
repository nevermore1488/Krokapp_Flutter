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

  CityTable.fromJson(dynamic json) {
    uniqueId = json["id_locale"];
    placeId = json["id"];
    name = json["name"];
    lang = json["lang"];
    logo = json["logo"];
    lastEditTime = json["last_edit_time"];
    visible = json["visible"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_locale"] = uniqueId;
    map["id"] = placeId;
    map["name"] = name;
    map["lang"] = lang;
    map["logo"] = logo;
    map["last_edit_time"] = lastEditTime;
    map["visible"] = visible;
    return map;
  }
}
