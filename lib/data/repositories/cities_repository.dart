import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';

class CitiesRepository {
  CitiesApi _citiesApi;
  CitiesDao _citiesDao;

  CitiesRepository(
    this._citiesApi,
    this._citiesDao,
  );

  Future<void> loadCitiesIfNeeded() async {
    var cities = await _citiesDao.getAll().first;
    if (cities.isEmpty) {
      cities = await _citiesApi.getCities(1).first;
      _citiesDao.add(cities);
    }
  }

  Stream<List<Place>> getCities() => _citiesDao.getAll().asPlaces();

  Stream<List<Place>> getCityById(int cityId) => _citiesDao.getCityById(cityId).asPlaces();
}
