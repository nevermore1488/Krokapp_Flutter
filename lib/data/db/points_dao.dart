import 'package:krokapp_multiplatform/data/db/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/point_table.dart';

abstract class PointsDao extends LocalizedDao<PointTable> {
  Stream<List<PointTable>> getPointsOfCity(int cityId);

  Stream<List<PointTable>> getPointById(int pointId);
}

class PointsDaoImpl extends LocalizedDaoImpl<PointTable> implements PointsDao {
  PointsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PointTable.TABLE_NAME,
          PointsJsonConverter(),
          "lang",
        );

  @override
  Stream<List<PointTable>> getPointsOfCity(int cityId) => query(
        "${getLocalizedSelectQuery()} and ${PointTable.COLUMN_CITY_ID} = $cityId",
        getLocalizedEngagedTables() + [CityTable.TABLE_NAME],
      );

  @override
  Stream<List<PointTable>> getPointById(int pointId) => query(
        "${getLocalizedSelectQuery()} and ${PointTable.COLUMN_PLACE_ID} = $pointId",
        getLocalizedEngagedTables(),
      );
}
