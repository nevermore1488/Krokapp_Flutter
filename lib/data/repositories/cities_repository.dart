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
        await _dao.selectLocalized().onError((error, stackTrace) => throw error!);

    if (savedCities.isEmpty) {
      int currentLanguageId = await _dao.getCurrentLanguageId();

      List<CityTable> citiesFromRemote =
          await _api.getCities(currentLanguageId).onError((error, stackTrace) => throw error!);

      _dao.insertWithReplace(citiesFromRemote);

      return convertTablesToPlaces(
        citiesFromRemote.where((element) => element.lang == currentLanguageId).toList(),
      );
    }
    return convertTablesToPlaces(savedCities);
  }
}

List<Place> convertTablesToPlaces(List<CityTable> tables) =>
    tables.map((e) => Place(e.placeId, e.name, e.logo)).toList();
