import 'package:krokapp_multiplatform/data/db/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';

abstract class LanguagesDao extends CommonDao<LanguageTable> {}

class LanguagesDaoImpl extends CommonDaoImpl<LanguageTable> implements LanguagesDao {
  LanguagesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          LanguageTable.TABLE_NAME,
          LanguagesJsonConverter(),
        );
}
