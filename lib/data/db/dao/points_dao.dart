import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/point_table.dart';

abstract class PointsDao extends CommonDao<PointTable> {}

class PointsDaoImpl extends LocalizedDao<PointTable> implements PointsDao {
  PointsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PointTable.TABLE_NAME,
          PointsJsonConverter(),
        );
}
