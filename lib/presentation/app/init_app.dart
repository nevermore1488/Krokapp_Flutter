import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/usecases/db_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/map_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/current_language_id_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/features_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<ObservableDatabaseExecutor>(
        future: DbUseCase().obtainDbExecutor(),
        builder: (context, snapshot) => SnapshotView<ObservableDatabaseExecutor>(
          snapshot: snapshot,
          onHasData: (value) => _createAppDependencies(snapshot.data!, KrokApp()),
          onLoading: KrokApp.createSplashScreen,
        ),
      );

  Widget _createAppDependencies(ObservableDatabaseExecutor dbExecutor, Widget child) =>
      MultiProvider(
        providers: [
          Provider<ObservableDatabaseExecutor>(
            create: (context) => dbExecutor,
          ),
          ProxyProvider<ObservableDatabaseExecutor, LanguagesRepository>(
            update: (context, value, previous) => LanguagesRepository(
                LanguagesApiImpl(), LanguagesDaoImpl(value), CurrentLanguageIdDaoImpl(value)),
          ),
          ProxyProvider<LanguagesRepository, LanguageUseCase>(
            update: (context, value, previous) => LanguageUseCase(value),
          ),
          ProxyProvider<ObservableDatabaseExecutor, CitiesRepository>(
            update: (context, value, previous) =>
                CitiesRepository(CitiesApiImpl(), CitiesDaoImpl(value)),
          ),
          ProxyProvider<ObservableDatabaseExecutor, PointsRepository>(
            update: (context, value, previous) => PointsRepository(PointsApiImpl(),
                PointsDaoImpl(value), FeatureDaoImpl(value), FeaturedPointsDaoImpl(value)),
          ),
          ProxyProvider2<CitiesRepository, PointsRepository, PlaceUseCase>(
            update: (context, cities, points, previous) => PlaceUseCase(cities, points),
          ),
          ProxyProvider2<LanguageUseCase, PlaceUseCase, KrokAppViewModel>(
            update: (context, languages, places, previous) => KrokAppViewModel(languages, places),
          ),
          ProxyProvider<PointsRepository, MapUseCase>(
            update: (context, value, previous) => MapUseCase(value),
          ),
        ],
        child: child,
      );
}
