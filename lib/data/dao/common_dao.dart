import 'dart:async';

import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';

abstract class CommonDao<T> {
  Future<void> add(List<T> entities);

  Future<void> deleteAll();

  Stream<List<T>> getAll();
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
  Future<void> add(List<T> entities) =>
      obsDbExecutor.add(tableName, converter.toJsonList(entities));

  @override
  Future<void> deleteAll() => obsDbExecutor.deleteAll(tableName);

  @override
  Stream<List<T>> getAll() => query(getSelectQuery(), getEngagedTables());

  Stream<List<T>> query(String query, List<String> engagedTables) =>
      obsDbExecutor.observableRawQuery(query, engagedTables).map(
            (event) => converter.fromJsonList(event),
          );

  String getSelectQuery() => "SELECT * FROM $tableName";

  List<String> getEngagedTables() => [tableName];
}
