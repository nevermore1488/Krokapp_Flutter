import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/cities_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/db/points_dao.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDependencies extends StatelessWidget {
  final Widget child;
  final DatabaseExecutor dbExecutor;

  AppDependencies({
    required this.child,
    required this.dbExecutor,
  });

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<DatabaseExecutor>(create: (context) => dbExecutor),
          ProxyProvider<DatabaseExecutor, ObservableDatabaseExecutor>(
            update: (context, value, previous) => ObservableDatabaseExecutor(value),
          ),
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
        child: child,
      );
}
