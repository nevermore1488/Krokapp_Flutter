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

  Stream<List<Place>> getCities() => _dao.getAllWithCurrentLanguage().asyncMap((event) async {
        if (event.isEmpty) {
          int currentLanguageId = await _dao.getCurrentLanguageId();

          List<CityTable> citiesFromRemote = await _api.getCities(currentLanguageId).first;

          _dao.replaceBy(citiesFromRemote);
        }

        return event;
      }).map((event) => event.map((e) => e.toPlace()).toList());

  Stream<List<Place>> getCityById(int cityId) => _dao.getCityById(cityId).asyncMap((event) async {
        if (event.isEmpty) {
          int currentLanguageId = await _dao.getCurrentLanguageId();

          List<CityTable> pointsFromRemote = await _api.getCities(currentLanguageId).first;

          _dao.replaceBy(pointsFromRemote);
        }

        return event;
      }).map((event) => event.map((e) => e.toPlace()).toList());
}
