import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/features_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/feature_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/featured_point_table.dart';
import 'package:krokapp_multiplatform/data/repositories/data_provider.dart';

class PointsRepository {
  PointsApi _api;
  FeatureDaoImpl _featureDao;
  FeaturedPointsDaoImpl _featurePointsDao;

  late DataProvider<List<FeaturedPointTable>> pointsProvider;

  Map<int, DataProvider<List<FeaturedPointTable>>> pointsByIdProviders = Map();
  Map<int, DataProvider<List<FeaturedPointTable>>> pointsOfCityProviders = Map();

  PointsRepository(
    this._api,
    this._featureDao,
    this._featurePointsDao,
  ) {
    pointsProvider = _createDefaultDataProvider(
      () => _featurePointsDao.getAll(),
    );
  }

  DataProvider<List<FeaturedPointTable>> _createDefaultDataProvider(
    Stream<List<FeaturedPointTable>> Function() _getData,
  ) =>
      DataProvider(
        _getData,
        (data) => _featurePointsDao.add(data),
        () => _api
            .getPoints(1)
            .map((event) => event.map((e) => FeaturedPointTable(pointTable: e)).toList())
            .first,
        (data) => data.isNotEmpty,
      );

  Stream<List<Place>> getPoints() => pointsProvider.getData().asPlaces();

  Stream<List<PlaceDetail>> getPointById(int pointId) {
    DataProvider<List<FeaturedPointTable>>? provider = pointsByIdProviders[pointId];

    if (provider == null) {
      provider = _createDefaultDataProvider(
        () => _featurePointsDao.getPointById(pointId),
      );
      pointsByIdProviders[pointId] = provider;
    }

    return provider.getData().asPlaces();
  }

  Stream<List<Place>> getPointsOfCity(int cityId) {
    DataProvider<List<FeaturedPointTable>>? provider = pointsOfCityProviders[cityId];

    if (provider == null) {
      provider = _createDefaultDataProvider(
        () => _featurePointsDao.getPointsOfCity(cityId),
      );
      pointsOfCityProviders[cityId] = provider;
    }

    return provider.getData().asPlaces();
  }

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
