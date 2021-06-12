import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class ObservableDatabaseExecutor {
  Future<List<Map<String, Object?>>> rawQuery(String query);

  Stream<List<Map<String, Object?>>> observableRawQuery(String query, List<String> engagedTables);

  Future<void> add(String tableName, List<Map<String, Object?>> entities);

  Future<void> deleteAll(String tableName);
}

class ObservableDatabaseExecutorImpl implements ObservableDatabaseExecutor {
  DatabaseExecutor _db;

  PublishSubject _changedTables = PublishSubject<List<String>>();

  ObservableDatabaseExecutorImpl(this._db);

  @override
  Future<List<Map<String, Object?>>> rawQuery(String query) => _db.rawQuery(query);

  @override
  Stream<List<Map<String, Object?>>> observableRawQuery(String query, List<String> engagedTables) =>
      _changedTables.stream
          .where(
              (event) => (event as List<String>).any((element) => engagedTables.contains(element)))
          .asyncMap((event) => _db.rawQuery(query))
          .mergeWith([_db.rawQuery(query).asStream()]);

  @override
  Future<void> add(String tableName, List<Map<String, Object?>> entities) async {
    Batch batch = _db.batch();
    entities.forEach((element) {
      batch.insert(
        tableName,
        element,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
    await batch.commit();

    _changedTables.add([tableName]);
  }

  @override
  Future<void> deleteAll(String tableName) async {
    _db.delete(tableName);
    _changedTables.add([tableName]);
  }
}
