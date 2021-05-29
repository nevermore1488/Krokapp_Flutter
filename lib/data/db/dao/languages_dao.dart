import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';

const String CURRENT_LANGUAGE_TABLE_NAME = "current_language";
const String CURRENT_LANGUAGE_ID_COLUMN_NAME = "current_language_id";

const String SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE = 'SELECT * FROM $CURRENT_LANGUAGE_TABLE_NAME';

const String CREATE_CURRENT_LANGUAGE_TABLE_CLAUSE = 'CREATE TABLE $CURRENT_LANGUAGE_TABLE_NAME('
    '$CURRENT_LANGUAGE_ID_COLUMN_NAME INTEGER PRIMARY KEY'
    ')';

abstract class LanguagesDao extends CommonDao<LanguageTable> {
  Future<int> getCurrentLanguageId();

  Future<void> setCurrentLanguageId(int languageId);
}

class LanguagesDaoImpl extends CommonDaoImpl<LanguageTable> implements LanguagesDao {
  LanguagesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          LanguageTable.TABLE_NAME,
          LanguagesJsonConverter(),
        );

  @override
  Future<int> getCurrentLanguageId() async {
    List<Map<String, Object?>> result = await obsDbExecutor.rawQuery(
      SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE,
    );
    return result.first[CURRENT_LANGUAGE_ID_COLUMN_NAME] as int;
  }

  @override
  Future<void> setCurrentLanguageId(int languageId) => obsDbExecutor.replaceBy(
        CURRENT_LANGUAGE_TABLE_NAME,
        [
          {CURRENT_LANGUAGE_ID_COLUMN_NAME: languageId}
        ].toList(),
      );
}
