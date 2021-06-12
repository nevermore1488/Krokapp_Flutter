import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/features_dao.dart';
import 'package:krokapp_multiplatform/data/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/tables/features_table.dart';
import 'package:krokapp_multiplatform/data/tables/featured_point_table.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

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

  Stream<List<Place>> getPointsBySelectArgs(
    SelectArgs selectArgs,
  ) =>
      _featurePointsDao.getPointsBySelectArgs(selectArgs).asPlaces();

  Future<void> savePointFeature(PlaceFeature placeFeature) async {
    _featureDao.add([
      FeaturesTable(
        placeFeature.placeId,
        placeFeature.isFavorite ? 1 : 0,
        placeFeature.isVisited ? 1 : 0,
      )
    ]);
  }

  Future<void> loadPoints() async {
    var cities = await _pointsDao.getAll().first;
    if (cities.isEmpty) {
      cities = await _pointsApi.getPoints(1).first;
      _pointsDao.add(cities);
    }
  }
}
