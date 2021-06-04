import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/current_language_id_table.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';
import 'package:krokapp_multiplatform/data/pojo/point_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUseCase {
  static const KROK_DB_NAME = 'krok_database.db';

  ObservableDatabaseExecutor? _dbExecutor;

  Future<ObservableDatabaseExecutor> obtainDbExecutor() async {
    if (_dbExecutor == null) {
      _dbExecutor = ObservableDatabaseExecutorImpl(await _createDb());
    }
    return _dbExecutor!;
  }

  Future<Database> _createDb() async => openDatabase(
        join(await getDatabasesPath(), KROK_DB_NAME),
        onCreate: (db, version) {
          db.transaction((txn) async {
            txn.execute(CurrentLanguageIdTable.CREATE_TABLE_CLAUSE);
            txn.execute(LanguageTable.CREATE_TABLE_CLAUSE);
            txn.execute(CityTable.CREATE_TABLE_CLAUSE);
            txn.execute(PointTable.CREATE_TABLE_CLAUSE);
          });
        },
        version: 1,
      );
}
