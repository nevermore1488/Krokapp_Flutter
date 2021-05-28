import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/db/db_helper.dart';
import 'package:krokapp_multiplatform/presentation/app/app_dependencies.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:sqflite/sqflite.dart';

class AppInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<Database>(
      future: DbHelper().obtainDb(),
      initialData: null,
      builder: (context, snapshot) => _onDbCreating(context, snapshot));

  Widget _onDbCreating(BuildContext context, AsyncSnapshot<Database> snapshot) {
    if (!snapshot.hasData)
      return _createSplashScreen();
    else
      return AppDependencies(
        child: KrokApp(),
        dbExecutor: snapshot.data!,
      );
  }

  Widget _createSplashScreen() => MaterialApp(
        home: Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: Text(
            "KrokApp",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
}
