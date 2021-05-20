import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/cities_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';

class CitiesRepository {
  CitiesApi _api;
  CitiesDao _dao;

  CitiesRepository(
    this._api,
    this._dao,
  );

  Future<List<Place>> getCities() async {
    List<CityTable> savedCities =
        await _dao.selectAll().onError((error, stackTrace) => throw error!);

    if (savedCities.isEmpty) {
      List<CityTable> citiesFromRemote =
          await _api.getCities().onError((error, stackTrace) => throw error!);
      _dao.insertWithReplace(citiesFromRemote);
      return convertTablesToPlaces(citiesFromRemote.where((element) => element.lang == 1).toList());
    }
    return convertTablesToPlaces(savedCities);
  }
}

List<Place> convertTablesToPlaces(List<CityTable> tables) =>
    tables.map((e) => Place(e.placeId, e.name, e.logo)).toList();
