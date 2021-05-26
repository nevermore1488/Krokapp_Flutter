import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/points_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/point_table.dart';

class PointsRepository {
  PointsApi _api;
  PointsDao _dao;

  PointsRepository(
    this._api,
    this._dao,
  );

  Stream<List<Place>> getAllPoints() => _dao.getAllWithCurrentLanguage().asyncMap((event) async {
        if (event.isEmpty) {
          int currentLanguageId = await _dao.getCurrentLanguageId();

          List<PointTable> pointsFromRemote = await _api.getPoints(currentLanguageId).first;

          _dao.replaceBy(pointsFromRemote);
        }

        return event;
      }).map((event) => event.map((e) => e.toPlace()).toList());

  Stream<List<Place>> getPointsOfCity(int cityId) =>
      _dao.getPointsOfCity(cityId).asyncMap((event) async {
        if (event.isEmpty) {
          int currentLanguageId = await _dao.getCurrentLanguageId();

          List<PointTable> pointsFromRemote = await _api.getPoints(currentLanguageId).first;

          _dao.replaceBy(pointsFromRemote);
        }

        return event;
      }).map((event) => event.map((e) => e.toPlace()).toList());
}
