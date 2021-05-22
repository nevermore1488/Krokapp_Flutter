import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/data/db/localized_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDb() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'krok_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      Batch batch = db.batch();
      batch.execute(CREATE_CURRENT_LANGUAGE_TABLE_CLAUSE);
      batch.execute(CREATE_CITIES_TABLE_CLAUSE);
      batch.insert(CURRENT_LANGUAGE_TABLE_NAME, {CURRENT_LANGUAGE_ID_COLUMN_NAME: 1});
      batch.commit();
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  return database;
}
//batch.insert(CURRENT_LANGUAGE_TABLE_NAME, {CURRENT_LANGUAGE_ID_COLUMN_NAME: languageId});
