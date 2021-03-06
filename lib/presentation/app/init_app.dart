import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/loading_data_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/dao/current_language_id_dao.dart';
import 'package:krokapp_multiplatform/data/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/featured_tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/dao/palce_features_dao.dart';
import 'package:krokapp_multiplatform/data/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tag_features_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_of_places_dao.dart';
import 'package:krokapp_multiplatform/data/database_provider.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/excursion_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/google_map_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/tags_repository.dart';
import 'package:krokapp_multiplatform/map/location_manager.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/resources.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppAsyncDependencies? _appAsyncDependencies;

class AppAsyncDependencies {
  ObservableDatabaseExecutor dbExecutor;
  SharedPreferences sharedPreferences;

  AppAsyncDependencies({
    required this.dbExecutor,
    required this.sharedPreferences,
  });
}

class InitApp extends StatelessWidget {
  Resources _resources;

  InitApp(this._resources);

  @override
  Widget build(BuildContext context) => FutureBuilder<AppAsyncDependencies>(
        future: obtainAsyncDependencies(),
        builder: (_, snapshot) => SnapshotView<AppAsyncDependencies>(
          snapshot: snapshot,
          onHasData: (value) {
            return _createAppDependencies(snapshot.data!, context, KrokApp());
          },
          onLoading: () => KrokApp.createSplashScreen(
            _resources.splashScreenLogoAnimationType,
            _resources.appLogoPath,
          ),
        ),
      );

  Future<AppAsyncDependencies> obtainAsyncDependencies() async {
    if (_appAsyncDependencies == null) {
      _appAsyncDependencies = AppAsyncDependencies(
        dbExecutor: await DatabaseProvider().obtainDbExecutor(),
        sharedPreferences: await SharedPreferences.getInstance(),
      );
    }
    return _appAsyncDependencies!;
  }

  Widget _createAppDependencies(
    AppAsyncDependencies appAsyncDependencies,
    BuildContext context,
    Widget child,
  ) =>
      MultiProvider(
        providers: [
          Provider<Resources>(
            create: (context) => _resources,
          ),
          Provider<LanguagesRepository>(
            create: (context) => LanguagesRepository(
                LanguagesApiImpl(_resources.baseUrl),
                LanguagesDaoImpl(appAsyncDependencies.dbExecutor),
                CurrentLanguageIdDaoImpl(appAsyncDependencies.dbExecutor)),
          ),
          Provider<CitiesRepository>(
            create: (context) => CitiesRepository(
              CitiesApiImpl(_resources.baseUrl, _resources.getCitiesPath),
              CitiesDaoImpl(appAsyncDependencies.dbExecutor),
            ),
          ),
          Provider<TagsRepository>(
            create: (context) => TagsRepository(
              TagsApiImpl(_resources.baseUrl, _resources.isLoadTags),
              TagsDaoImpl(appAsyncDependencies.dbExecutor),
              FeaturedTagsDaoImpl(appAsyncDependencies.dbExecutor),
              TagFeaturesDaoImpl(appAsyncDependencies.dbExecutor),
              TagsOfPlacesDaoImpl(appAsyncDependencies.dbExecutor),
            ),
          ),
          Provider<ExcursionRepository>(
            create: (context) => ExcursionRepository(
              appAsyncDependencies.sharedPreferences,
            ),
          ),
          Provider<GoogleMapRepository>(
            create: (context) => GoogleMapRepository(
              Resources.GOOGLE_MAP_API_KEY,
            ),
          ),
          Provider<PointsRepository>(
            create: (context) => PointsRepository(
              PointsApiImpl(_resources.baseUrl, _resources.getPointsPath),
              PointsDaoImpl(appAsyncDependencies.dbExecutor),
              PlaceFeaturesDaoImpl(appAsyncDependencies.dbExecutor),
              FeaturedPointsDaoImpl(appAsyncDependencies.dbExecutor),
              TagsOfPlacesDaoImpl(appAsyncDependencies.dbExecutor),
            ),
          ),
          Provider<LocationManager>(
            create: (context) => LocationManagerImpl(),
          ),
          ProxyProvider<LanguagesRepository, LanguageUseCase>(
            update: (context, value, previous) => LanguageUseCase(value),
          ),
          ProxyProvider2<CitiesRepository, PointsRepository, PlaceUseCase>(
            update: (context, cities, points, previous) =>
                PlaceUseCase(cities, points),
          ),
          ProxyProvider3<CitiesRepository, PointsRepository, TagsRepository,
              LoadingDataUseCase>(
            update: (context, cities, points, tags, previous) =>
                LoadingDataUseCase(cities, points, tags),
          ),
          ProxyProvider2<LoadingDataUseCase, LanguageUseCase, KrokAppViewModel>(
            update: (context, loadingDataUseCase, languageUseCase, previous) =>
                KrokAppViewModel(loadingDataUseCase, languageUseCase),
          ),
        ],
        child: child,
      );
}
