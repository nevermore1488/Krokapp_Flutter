import 'package:sqflite/sqflite.dart';

abstract class CommonDao<T> {
  Future<void> deleteAll();

  Future<List<T>> selectAll();

  Future<void> insertWithReplace(List<T> entities);
}

abstract class CommonDaoImpl<T> implements CommonDao<T> {
  Future<Database> _dbFuture;
  String _tableName;

  CommonDaoImpl(
    this._dbFuture,
    this._tableName,
  );

  List<Map<String, Object?>> entitiesToJson(List<T> entities);

  List<T> jsonToEntities(List<Map<String, Object?>> json);

  @override
  Future<void> deleteAll() async {
    (await _dbFuture).delete(_tableName);
  }

  @override
  Future<List<T>> selectAll() async {
    List<Map<String, Object?>> query =
        await (await _dbFuture).rawQuery("SELECT * FROM $_tableName");

    return jsonToEntities(query);
  }

  @override
  Future<void> insertWithReplace(List<T> entities) async {
    Batch batch = (await _dbFuture).batch();

    entitiesToJson(entities).forEach((element) {
      batch.insert(_tableName, element);
    });

    batch.commit();
  }
}
