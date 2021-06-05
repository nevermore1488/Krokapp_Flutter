import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/usecases/db_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/current_language_id_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:provider/provider.dart';

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FutureBuilder<ObservableDatabaseExecutor>(
        future: DbUseCase().obtainDbExecutor(),
        builder: (context, snapshot) => KrokApp.createAppSnapshotView<ObservableDatabaseExecutor>(
          snapshot,
          (value) => _createAppDependencies(snapshot.data!, KrokApp()),
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
          ProxyProvider<LanguageUseCase, KrokAppViewModel>(
            update: (context, value, previous) => KrokAppViewModel(value),
          ),
        ],
        child: child,
      );
}
