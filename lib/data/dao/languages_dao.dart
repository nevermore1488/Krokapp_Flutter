import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/languages_table.dart';

abstract class LanguagesDao extends CommonDao<LanguagesTable> {
  /// Its like getAll, but allier, you know?
  Stream<List<LanguagesTable>> getVeryAll();
}

class LanguagesDaoImpl extends LocalizedDao<LanguagesTable> implements LanguagesDao {
  LanguagesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          LanguagesTable.TABLE_NAME,
          LanguagesJsonConverter(),
          langIdColumnName: LanguagesTable.COLUMN_ID,
        );

  @override
  Stream<List<LanguagesTable>> getVeryAll() => query("SELECT * FROM $tableName", [tableName]);
}
