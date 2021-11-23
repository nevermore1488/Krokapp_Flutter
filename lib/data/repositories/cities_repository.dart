import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';

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

  Future<void> loadCities() async {
    var cities = await _citiesDao.getAll().first;
    final citiesFromRemote = _citiesApi.getCities(111111);
    if (cities.isEmpty) {
      cities = (await citiesFromRemote)
          .where((element) => element.name.replaceAll(' ', '').isNotEmpty)
          .toList();
      _citiesDao.add(cities);
    }
  }
}
