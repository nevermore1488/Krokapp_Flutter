import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

class CitiesRepository {
  CitiesApi _citiesApi;
  CitiesDao _citiesDao;

  CitiesRepository(
    this._citiesApi,
    this._citiesDao,
  );

  Stream<List<Place>> getCitiesBySelectArgs(
    SelectArgs selectArgs,
  ) =>
      _citiesDao.getCitiesBySelectArgs(selectArgs).asPlaces();

  Future<void> loadCitiesIfNeeded() async {
    var cities = await _citiesDao.getAll().first;
    if (cities.isEmpty) {
      cities = await _citiesApi.getCities(1).first;
      _citiesDao.add(cities);
    }
  }
}
