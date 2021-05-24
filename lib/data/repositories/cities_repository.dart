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

  Stream<List<Place>> getCities() => _dao.selectLocalized().asyncMap((event) async {
        if (event.isNotEmpty) return event;

        int currentLanguageId = await _dao.getCurrentLanguageId();

        List<CityTable> citiesFromRemote =
            await _api.getCities(currentLanguageId).onError((error, stackTrace) => throw error!);

        _dao.replaceBy(citiesFromRemote);
        return citiesFromRemote;
      }).map((event) => event.map((e) => e.toPlace()).toList());
}
