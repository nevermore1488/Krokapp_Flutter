import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/current_language_id_table.dart';

abstract class LocalizedDao<T> extends CommonDaoImpl<T> {
  static const String SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE =
      'SELECT * FROM ${CurrentLanguageIdTable.TABLE_NAME}';

  String langIdColumnName;

  LocalizedDao(
    ObservableDatabaseExecutor streamDbExecutor,
    String tableName,
    JsonConverter<T> jsonConverter, {
    this.langIdColumnName = "lang",
  }) : super(
          streamDbExecutor,
          tableName,
          jsonConverter,
        );

  @override
  String getSelectQuery() =>
      "${super.getSelectQuery()} ${beforeWhereStatement()}"
      " WHERE $langIdColumnName = ($SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE)";

  @override
  List<String> getEngagedTables() =>
      super.getEngagedTables() + [CurrentLanguageIdTable.TABLE_NAME];

  String beforeWhereStatement() => "";
}
