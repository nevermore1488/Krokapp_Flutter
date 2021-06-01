import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';
import 'package:krokapp_multiplatform/data/pojo/point_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database> obtainDb() async {
    if (db == null) {
      db = await _createDb();
    }
    return db!;
  }

  Future<Database> _createDb() async => openDatabase(
        join(await getDatabasesPath(), 'krok_database.db'),
        onCreate: (db, version) {
          db.transaction((txn) async {
            txn.execute(CREATE_CURRENT_LANGUAGE_TABLE_CLAUSE);
            txn.execute(CityTable.CREATE_TABLE_CLAUSE);
            txn.execute(PointTable.CREATE_TABLE_CLAUSE);
            txn.execute(LanguageTable.CREATE_TABLE_CLAUSE);
          });
        },
        version: 1,
      );
}
