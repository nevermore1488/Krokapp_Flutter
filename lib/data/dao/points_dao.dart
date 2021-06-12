import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';

abstract class PointsDao extends CommonDao<PointsTable> {}

class PointsDaoImpl extends LocalizedDao<PointsTable> implements PointsDao {
  PointsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PointsTable.TABLE_NAME,
          PointsJsonConverter(),
        );
}
