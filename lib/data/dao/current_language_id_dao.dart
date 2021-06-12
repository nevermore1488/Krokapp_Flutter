import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/current_language_id_table.dart';

abstract class CurrentLanguageIdDao extends CommonDao<CurrentLanguageIdTable> {}

class CurrentLanguageIdDaoImpl extends CommonDaoImpl<CurrentLanguageIdTable>
    implements CurrentLanguageIdDao {
  CurrentLanguageIdDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          CurrentLanguageIdTable.TABLE_NAME,
          CurrentLanguageIdJsonConverter(),
        );
}
