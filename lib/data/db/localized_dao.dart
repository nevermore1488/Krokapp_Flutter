import 'package:krokapp_multiplatform/data/db/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/json_converter.dart';

const String CURRENT_LANGUAGE_TABLE_NAME = "current_language";
const String CURRENT_LANGUAGE_ID_COLUMN_NAME = "current_language_id";

const String SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE = 'SELECT * FROM $CURRENT_LANGUAGE_TABLE_NAME';

const String CREATE_CURRENT_LANGUAGE_TABLE_CLAUSE = 'CREATE TABLE $CURRENT_LANGUAGE_TABLE_NAME('
    '$CURRENT_LANGUAGE_ID_COLUMN_NAME INTEGER PRIMARY KEY'
    ')';

abstract class LocalizedDao<T> extends CommonDao<T> {
  Future<int> getCurrentLanguageId();

  Future<void> setCurrentLanguageId(int languageId);

  Stream<List<T>> getAllWithCurrentLanguage();
}

abstract class LocalizedDaoImpl<T> extends CommonDaoImpl<T> implements LocalizedDao<T> {
  String _langColumnName;

  LocalizedDaoImpl(
    ObservableDatabaseExecutor streamDbExecutor,
    String tableName,
    JsonConverter<T> jsonConverter,
    this._langColumnName,
  ) : super(streamDbExecutor, tableName, jsonConverter);

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

  @override
  Stream<List<T>> getAllWithCurrentLanguage() =>
      query(getLocalizedSelectQuery(), getLocalizedEngagedTables());

  String getLocalizedSelectQuery() =>
      "${getCommonSelectQuery()} WHERE $_langColumnName = ($SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE)";

  List<String> getLocalizedEngagedTables() =>
      getCommonEngagedTables() + [CURRENT_LANGUAGE_TABLE_NAME];
}
