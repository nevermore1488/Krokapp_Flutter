import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/features_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/feature_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/featured_point_table.dart';

class PointsRepository {
  PointsApi _pointsApi;
  PointsDao _pointsDao;
  FeatureDao _featureDao;
  FeaturedPointsDao _featurePointsDao;

  PointsRepository(
    this._pointsApi,
    this._pointsDao,
    this._featureDao,
    this._featurePointsDao,
  );

  Stream<List<Place>> getPoints() => _featurePointsDao.getAll().asPlaces();

  Future<void> loadPointsIfNeeded() async {
    var cities = await _pointsDao.getAll().first;
    if (cities.isEmpty) {
      cities = await _pointsApi.getPoints(1).first;
      _pointsDao.add(cities);
    }
  }

  Stream<List<PlaceDetail>> getPointById(int pointId) =>
      _featurePointsDao.getPointById(pointId).asPlaces();

  Stream<List<Place>> getPointsOfCity(int cityId) =>
      _featurePointsDao.getPointsOfCity(cityId).asPlaces();

  Stream<List<Place>> getFavorites() => _featurePointsDao.getFavorites().asPlaces();

  Stream<List<Place>> getVisited() => _featurePointsDao.getVisited().asPlaces();

  Future<void> savePlaceFeature(PlaceFeature placeFeature) async {
    _featureDao.add([
      FeatureTable(
        placeFeature.placeId,
        placeFeature.isFavorite ? 1 : 0,
        placeFeature.isVisited ? 1 : 0,
      )
    ]);
  }
}
