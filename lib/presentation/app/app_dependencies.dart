import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/init/app_initializer.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/app/splash_screen.dart';
import 'package:provider/provider.dart';

class AppDependencies extends StatelessWidget {
  final _appInitializer = AppInitializer();

  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
      future: _appInitializer.initApp(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return _createApp(context);
        else if (snapshot.hasError)
          return MaterialApp(home: Text(snapshot.error!.toString()));
        else
          return SplashScreen();
      });

  Widget _createApp(BuildContext context) => MultiProvider(
        providers: [
          Provider<ObservableDatabaseExecutor>(create: (context) => _appInitializer.dbExecutor),
          ProxyProvider<ObservableDatabaseExecutor, CitiesRepository>(
            update: (context, value, previous) => CitiesRepository(
              CitiesApiImpl(),
              CitiesDaoImpl(value),
            ),
          ),
          ProxyProvider<ObservableDatabaseExecutor, PointsRepository>(
            update: (context, value, previous) => PointsRepository(
              PointsApiImpl(),
              PointsDaoImpl(value),
            ),
          ),
        ],
        child: KrokApp(_appInitializer.selectedLocale),
      );
}
