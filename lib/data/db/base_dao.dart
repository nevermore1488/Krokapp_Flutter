import 'package:sqflite/sqflite.dart';

abstract class CommonDao<T> {
  Future<void> deleteAll();

  Future<void> insertWithReplace(List<T> entities);

  Future<void> replaceBy(List<T> entities);

  Future<List<T>> selectAll();
}

abstract class CommonDaoImpl<T> implements CommonDao<T> {
  Future<Database> dbFuture;
  String tableName;

  CommonDaoImpl(
    this.dbFuture,
    this.tableName,
  );

  List<Map<String, Object?>> entitiesToJson(List<T> entities);

  List<T> jsonToEntities(List<Map<String, Object?>> json);

  @override
  Future<void> deleteAll() async {
    (await dbFuture).delete(tableName);
  }

  @override
  Future<void> insertWithReplace(List<T> entities) async {
    Batch batch = (await dbFuture).batch();

    entitiesToJson(entities).forEach((element) {
      batch.insert(tableName, element);
    });

    batch.commit();
  }

  @override
  Future<void> replaceBy(List<T> entities) async {
    Batch batch = (await dbFuture).batch();
    batch.delete(tableName);
    entitiesToJson(entities).forEach((element) {
      batch.insert(tableName, element);
    });

    batch.commit();
  }

  @override
  Future<List<T>> selectAll() async {
    List<Map<String, Object?>> query =
        await (await dbFuture).rawQuery("SELECT * FROM $tableName where lang = 1");

    return jsonToEntities(query);
  }
}
