import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/point_table.dart';

abstract class PointsDao extends CommonDao<PointTable> {
  Stream<List<PointTable>> getPointsOfCity(int cityId);

  Stream<List<PointTable>> getPointById(int pointId);
}

class PointsDaoImpl extends LocalizedDao<PointTable> implements PointsDao {
  PointsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PointTable.TABLE_NAME,
          PointsJsonConverter(),
        );

  @override
  Stream<List<PointTable>> getPointsOfCity(int cityId) => query(
        "${getSelectQuery()} and ${PointTable.COLUMN_CITY_ID} = $cityId",
        getEngagedTables() + [CityTable.TABLE_NAME],
      );

  @override
  Stream<List<PointTable>> getPointById(int pointId) => query(
        "${getSelectQuery()} and ${PointTable.COLUMN_PLACE_ID} = $pointId",
        getEngagedTables(),
      );
}
