import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';
import 'package:krokapp_multiplatform/data/tables/current_language_id_table.dart';
import 'package:krokapp_multiplatform/data/tables/place_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/languages_table.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';
import 'package:krokapp_multiplatform/data/tables/tag_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_of_places_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
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
            txn.execute(LanguagesTable.CREATE_TABLE_CLAUSE);
            txn.execute(CitiesTable.CREATE_TABLE_CLAUSE);
            txn.execute(PointsTable.CREATE_TABLE_CLAUSE);
            txn.execute(PlaceFeaturesTable.CREATE_TABLE_CLAUSE);
            txn.execute(TagsTable.CREATE_TABLE_CLAUSE);
            txn.execute(TagFeaturesTable.CREATE_TABLE_CLAUSE);
            txn.execute(TagsOfPlacesTable.CREATE_TABLE_CLAUSE);
          });
        },
        version: 1,
      );
}
