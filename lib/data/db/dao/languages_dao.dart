import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/language_table.dart';

abstract class LanguagesDao extends CommonDao<LanguageTable> {
  /// Its like getAll, but allier, you know?
  Stream<List<LanguageTable>> getVeryAll();
}

class LanguagesDaoImpl extends LocalizedDao<LanguageTable> implements LanguagesDao {
  LanguagesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          LanguageTable.TABLE_NAME,
          LanguagesJsonConverter(),
          langIdColumnName: LanguageTable.COLUMN_ID,
        );

  @override
  Stream<List<LanguageTable>> getVeryAll() => query("SELECT * FROM $tableName", [tableName]);
}
