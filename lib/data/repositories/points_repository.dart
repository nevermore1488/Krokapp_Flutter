import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/points_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/pojo/point_table.dart';
import 'package:krokapp_multiplatform/data/repositories/data_provider.dart';

class PointsRepository {
  PointsApi _api;
  PointsDao _dao;

  late DataProvider<List<PointTable>> pointsProvider;

  Map<int, DataProvider<List<PointTable>>> pointsByIdProviders = Map();
  Map<int, DataProvider<List<PointTable>>> pointsOfCityProviders = Map();

  PointsRepository(
    this._api,
    this._dao,
  ) {
    pointsProvider = _createDefaultDataProvider(
      () => _dao.getAllWithCurrentLanguage(),
    );
  }

  DataProvider<List<PointTable>> _createDefaultDataProvider(
    Stream<List<PointTable>> Function() _getData,
  ) =>
      DataProvider(
        _getData,
        (data) => _dao.replaceBy(data),
        () => _api.getPoints(1).first,
        (data) => data.isNotEmpty,
      );

  Stream<List<Place>> getPoints() => pointsProvider.getData().asPlaces();

  Stream<List<PlaceDetail>> getPointById(int pointId) {
    DataProvider<List<PointTable>>? provider = pointsByIdProviders[pointId];

    if (provider == null) {
      provider = _createDefaultDataProvider(
        () => _dao.getPointById(pointId),
      );
      pointsByIdProviders[pointId] = provider;
    }

    return provider.getData().asPlaceDetails();
  }

  Stream<List<Place>> getPointsOfCity(int cityId) {
    DataProvider<List<PointTable>>? provider = pointsOfCityProviders[cityId];

    if (provider == null) {
      provider = _createDefaultDataProvider(
        () => _dao.getPointsOfCity(cityId),
      );
      pointsOfCityProviders[cityId] = provider;
    }

    return provider.getData().asPlaces();
  }
}
