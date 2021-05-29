import 'dart:async';

import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/json_converter.dart';

abstract class CommonDao<T> {
  Stream<List<T>> getAll();

  Future<void> replaceBy(List<T> entities);
}

class CommonDaoImpl<T> implements CommonDao<T> {
  ObservableDatabaseExecutor obsDbExecutor;
  String tableName;
  JsonConverter<T> converter;

  CommonDaoImpl(
    this.obsDbExecutor,
    this.tableName,
    this.converter,
  );

  @override
  Future<void> replaceBy(List<T> entities) =>
      obsDbExecutor.replaceBy(tableName, converter.toJsonList(entities));

  @override
  Stream<List<T>> getAll() => query(getSelectQuery(), getEngagedTables());

  Stream<List<T>> query(String query, List<String> engagedTables) =>
      obsDbExecutor.observableRawQuery(query, engagedTables).map(
            (event) => converter.fromJsonList(event),
          );

  String getSelectQuery() => "SELECT * FROM $tableName";

  List<String> getEngagedTables() => [tableName];
}
