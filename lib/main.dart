import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/cities_dao.dart';
import 'package:krokapp_multiplatform/data/db/db_helper.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/presentation/krok_app.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(
      FutureBuilder<Database>(
          future: DbHelper().obtainDb(),
          initialData: null,
          builder: (context, snapshot) => _onDbCreating(context, snapshot)),
    );

Widget _onDbCreating(BuildContext context, AsyncSnapshot<Database> snapshot) {
  if (!snapshot.hasData)
    return MaterialApp(
      home: Container(
        color: Colors.orange,
        alignment: Alignment.center,
        child: Text(
          "KrokApp",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  else
    return _onDbCreated(context, snapshot.data!);
}

Widget _onDbCreated(BuildContext context, Database db) => MultiProvider(
      providers: [
        Provider<DatabaseExecutor>(create: (context) => db),
        ProxyProvider<DatabaseExecutor, ObservableDatabaseExecutor>(
          update: (context, value, previous) => ObservableDatabaseExecutor(value),
        ),
        ProxyProvider<ObservableDatabaseExecutor, CitiesRepository>(
          update: (context, value, previous) => CitiesRepository(
            CitiesApiImpl(),
            CitiesDaoImpl(value),
          ),
        ),
      ],
      child: KrokApp(),
    );
