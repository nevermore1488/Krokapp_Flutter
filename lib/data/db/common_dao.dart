import 'dart:async';

import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/json_converter.dart';

abstract class CommonDao<T> {
  Stream<List<T>> selectAll();

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
      obsDbExecutor.replaceBy(tableName, entities.map((e) => converter.toJson(e)).toList());

  @override
  Stream<List<T>> selectAll() {
    String query = "SELECT * FROM $tableName where lang = 1";

    return obsDbExecutor.observableRawQuery(query, [tableName]).map(
      (event) => event.map((e) => converter.fromJson(e)).toList(),
    );
  }
}
