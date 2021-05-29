import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/json_converter.dart';

abstract class LocalizedDao<T> extends CommonDaoImpl<T> {
  LocalizedDao(
    ObservableDatabaseExecutor streamDbExecutor,
    String tableName,
    JsonConverter<T> jsonConverter,
  ) : super(streamDbExecutor, tableName, jsonConverter);

  @override
  String getSelectQuery() =>
      "${super.getSelectQuery()} WHERE lang = ($SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE)";

  @override
  List<String> getEngagedTables() => super.getEngagedTables() + [CURRENT_LANGUAGE_TABLE_NAME];
}
