import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/tables/features_table.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';

class FeaturedPointTable {
  late PointsTable pointTable;
  late FeaturesTable featureTable;

  FeaturedPointTable({
    required this.pointTable,
    FeaturesTable? featureTable,
  }) {
    this.featureTable = featureTable ?? FeaturesTable(this.pointTable.placeId, 0, 0);
  }

  FeaturedPointTable.fromJson(dynamic json) {
    pointTable = PointsTable.fromJson(json);
    featureTable = FeaturesTable.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map.addAll(pointTable.toJson());
    map.addAll(featureTable.toJson());
    return map;
  }

  PlaceDetail toPlace() {
    var placeDetail = pointTable.toPlaceDetail();
    placeDetail.isShowFavorite = true;
    placeDetail.isShowVisited = true;
    placeDetail.isFavorite = featureTable.isFavorite == 1;
    placeDetail.isVisited = featureTable.isVisited == 1;
    return placeDetail;
  }
}

class FeaturedPointsJsonConverter extends JsonConverter<FeaturedPointTable> {
  @override
  FeaturedPointTable fromJson(Map<String, Object?> json) => FeaturedPointTable.fromJson(json);

  @override
  Map<String, Object?> toJson(FeaturedPointTable pojo) => pojo.toJson();
}

extension FeaturedPointsStreamMaping on Stream<List<FeaturedPointTable>> {
  Stream<List<PlaceDetail>> asPlaces() =>
      this.map((event) => event.map((e) => e.toPlace()).toList());
}
