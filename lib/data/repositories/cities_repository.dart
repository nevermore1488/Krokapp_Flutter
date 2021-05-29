import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/repositories/data_provider.dart';

class CitiesRepository {
  CitiesApi _api;
  CitiesDao _dao;

  late DataProvider<List<CityTable>> citiesProvider;

  Map<int, DataProvider<List<CityTable>>> citiesByIdProviders = Map();

  CitiesRepository(
    this._api,
    this._dao,
  ) {
    citiesProvider = _createDefaultDataProvider(
      () => _dao.getAll(),
    );
  }

  DataProvider<List<CityTable>> _createDefaultDataProvider(
    Stream<List<CityTable>> Function() _getData,
  ) =>
      DataProvider(
        _getData,
        (data) => _dao.replaceBy(data),
        () => _api.getCities(1).first,
        (data) => data.isNotEmpty,
      );

  Stream<List<Place>> getCities() => citiesProvider.getData().asPlaces();

  Stream<List<Place>> getCityById(int cityId) {
    DataProvider<List<CityTable>>? provider = citiesByIdProviders[cityId];

    if (provider == null) {
      provider = _createDefaultDataProvider(
        () => _dao.getCityById(cityId),
      );
      citiesByIdProviders[cityId] = provider;
    }

    return provider.getData().asPlaces();
  }
}
