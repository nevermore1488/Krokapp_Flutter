import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sqflite/sqlite_api.dart';

class ObservableDatabaseExecutor {
  DatabaseExecutor _db;

  PublishSubject _changedTables = PublishSubject<List<String>>();

  ObservableDatabaseExecutor(this._db);

  Future<List<Map<String, Object?>>> rawQuery(String query) => _db.rawQuery(query);

  Stream<List<Map<String, Object?>>> observableRawQuery(String query, List<String> engagedTables) =>
      _changedTables.stream
          .where(
              (event) => (event as List<String>).any((element) => engagedTables.contains(element)))
          .asyncMap((event) => _db.rawQuery(query))
          .mergeWith([_db.rawQuery(query).asStream()]);

  Future<void> replaceBy(String tableName, List<Map<String, Object?>> entities) async {
    Batch batch = _db.batch();
    batch.delete(tableName);
    entities.forEach((element) {
      batch.insert(tableName, element);
    });
    await batch.commit();

    _changedTables.add([tableName]);
  }
}
