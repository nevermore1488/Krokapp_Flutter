import 'package:krokapp_multiplatform/data/db/base_dao.dart';
import 'package:sqflite/sqflite.dart';

const String CURRENT_LANGUAGE_TABLE_NAME = "current_language";
const String CURRENT_LANGUAGE_ID_COLUMN_NAME = "current_language_id";

const String SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE = 'SELECT * FROM $CURRENT_LANGUAGE_TABLE_NAME';

const String CREATE_CURRENT_LANGUAGE_TABLE_CLAUSE = 'CREATE TABLE $CURRENT_LANGUAGE_TABLE_NAME('
    '$CURRENT_LANGUAGE_ID_COLUMN_NAME INTEGER PRIMARY KEY'
    ')';

abstract class LocalizedDao<T> extends CommonDao<T> {
  Future<int> getCurrentLanguageId();

  Future<void> setCurrentLanguageId(int languageId);

  Future<List<T>> selectLocalized();
}

abstract class LocalizedDaoImpl<T> extends CommonDaoImpl<T> implements LocalizedDao<T> {
  String _langColumnName;

  LocalizedDaoImpl(
    Future<Database> dbFuture,
    String tableName,
    this._langColumnName,
  ) : super(dbFuture, tableName);

  @override
  Future<int> getCurrentLanguageId() async {
    List<Map<String, Object?>> result = await (await dbFuture).rawQuery(
      SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE,
    );
    return result.first[CURRENT_LANGUAGE_ID_COLUMN_NAME] as int;
  }

  @override
  Future<void> setCurrentLanguageId(int languageId) async {
    Batch batch = (await dbFuture).batch();

    batch.delete(CURRENT_LANGUAGE_TABLE_NAME);
    batch.insert(CURRENT_LANGUAGE_TABLE_NAME, {CURRENT_LANGUAGE_ID_COLUMN_NAME: languageId});

    batch.commit();
  }

  @override
  Future<List<T>> selectLocalized() async {
    List<Map<String, Object?>> query = await (await dbFuture).rawQuery(
      "SELECT * FROM $tableName where $_langColumnName = ($SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE)",
    );

    return jsonToEntities(query);
  }
}
