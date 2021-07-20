import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/loading_data_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/map_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/dao/current_language_id_dao.dart';
import 'package:krokapp_multiplatform/data/dao/featured_points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/features_dao.dart';
import 'package:krokapp_multiplatform/data/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/dao/selected_tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_of_places_dao.dart';
import 'package:krokapp_multiplatform/data/database_provider.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/tags_repository.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      FutureBuilder<ObservableDatabaseExecutor>(
        future: DatabaseProvider().obtainDbExecutor(),
        builder: (context, snapshot) =>
            SnapshotView<ObservableDatabaseExecutor>(
          snapshot: snapshot,
          onHasData: (value) =>
              _createAppDependencies(snapshot.data!, KrokApp()),
          onLoading: KrokApp.createSplashScreen,
        ),
      );

  Widget _createAppDependencies(
          ObservableDatabaseExecutor dbExecutor, Widget child) =>
      MultiProvider(
        providers: [
          Provider<ObservableDatabaseExecutor>(
            create: (context) => dbExecutor,
          ),
          ProxyProvider<ObservableDatabaseExecutor, LanguagesRepository>(
            update: (context, value, previous) => LanguagesRepository(
                LanguagesApiImpl(),
                LanguagesDaoImpl(value),
                CurrentLanguageIdDaoImpl(value)),
          ),
          ProxyProvider<LanguagesRepository, LanguageUseCase>(
            update: (context, value, previous) => LanguageUseCase(value),
          ),
          ProxyProvider<ObservableDatabaseExecutor, CitiesRepository>(
            update: (context, value, previous) =>
                CitiesRepository(CitiesApiImpl(), CitiesDaoImpl(value)),
          ),
          ProxyProvider<ObservableDatabaseExecutor, TagsRepository>(
            update: (context, value, previous) => TagsRepository(
              TagsApiImpl(),
              TagsDaoImpl(value),
              SelectedTagsDaoImpl(value),
              TagsOfPlacesDaoImpl(value),
            ),
          ),
          ProxyProvider<ObservableDatabaseExecutor, PointsRepository>(
            update: (context, value, previous) => PointsRepository(
              PointsApiImpl(),
              PointsDaoImpl(value),
              FeatureDaoImpl(value),
              FeaturedPointsDaoImpl(value),
              TagsOfPlacesDaoImpl(value),
            ),
          ),
          ProxyProvider2<CitiesRepository, PointsRepository, PlaceUseCase>(
            update: (context, cities, points, previous) =>
                PlaceUseCase(cities, points),
          ),
          ProxyProvider4<LanguagesRepository, CitiesRepository,
              PointsRepository, TagsRepository, LoadingDataUseCase>(
            update: (context, languages, cities, points, tags, previous) =>
                LoadingDataUseCase(languages, cities, points, tags),
          ),
          ProxyProvider<LoadingDataUseCase, KrokAppViewModel>(
            update: (context, loadingDataUseCase, previous) =>
                KrokAppViewModel(loadingDataUseCase),
          ),
          ProxyProvider<PointsRepository, MapUseCase>(
            update: (context, value, previous) => MapUseCase(value),
          ),
        ],
        child: child,
      );
}
