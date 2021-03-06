import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/palce_features_dao.dart';
import 'package:krokapp_multiplatform/data/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_of_places_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/data/tables/featured_point_table.dart';
import 'package:krokapp_multiplatform/data/tables/place_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_of_places_table.dart';

class PointsRepository {
  PointsApi _pointsApi;
  PointsDao _pointsDao;
  PlaceFeaturesDao _featureDao;
  FeaturedPointsDao _featurePointsDao;
  TagsOfPlacesDao _tagsOfPlacesDao;

  PointsRepository(
    this._pointsApi,
    this._pointsDao,
    this._featureDao,
    this._featurePointsDao,
    this._tagsOfPlacesDao,
  );

  Stream<List<Place>> getPointsBySelectArgs(
    SelectArgs selectArgs,
  ) =>
      _featurePointsDao.getPointsBySelectArgs(selectArgs).asPlaces();

  Future<void> savePointFeature(PlaceFeature placeFeature) async {
    _featureDao.add([
      PlaceFeaturesTable(
        placeFeature.placeId,
        placeFeature.isFavorite ? 1 : 0,
        placeFeature.isVisited ? 1 : 0,
      )
    ]);
  }

  Future<void> loadPoints() async {
    var points = await _pointsDao.getAll().first;
    final pointsFromRemote = _pointsApi.getPoints(111111);
    if (points.isEmpty) {
      points = (await pointsFromRemote)
          .where((element) => element.name.replaceAll(' ', '').isNotEmpty)
          .toList();
      final tagsOfPointsGrouped = points
          .where((element) => element.lang == 1)
          .map((point) => point.tags
              .map((e) => TagsOfPlacesTable(e, point.placeId))
              .toList());

      final tagsOfPoints = <TagsOfPlacesTable>[];
      for (List<TagsOfPlacesTable> group in tagsOfPointsGrouped) {
        tagsOfPoints.addAll(group);
      }
      _pointsDao.add(points);
      _tagsOfPlacesDao.add(tagsOfPoints);
    }
  }
}
