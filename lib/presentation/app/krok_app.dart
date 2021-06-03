import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/cities_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/points_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/presentation/main/navigation_menu_drawer.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/ui/rotating_widget.dart';
import 'package:provider/provider.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KrokAppViewModel vm = Provider.of(context);

    return FutureBuilder<bool>(
        future: vm.initApp(),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return _createMainScreenDependencies(
              _createMainScreen(vm.selectedLocale),
            );
          else if (snapshot.hasError)
            return _createErrorScreen(snapshot.error!.toString());
          else
            return createSplashScreen();
        });
  }

  Widget _createMainScreenDependencies(Widget child) => MultiProvider(
        providers: [
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

  Widget _createMainScreen(Locale selectedLocale) => MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange,
          primaryColorBrightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => PlacePage(
                placeMode: CitiesMode(),
                drawer: NavigationMenuDrawer(),
              ),
        },
        locale: selectedLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      );

  Widget _createErrorScreen(String errorMessage) => MaterialApp(
        home: Center(child: Text(errorMessage)),
      );

  static Widget createSplashScreen() => MaterialApp(
        home: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: RotatingWidget(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image(image: AssetImage('drawables/krok_icon.png')),
            ),
          ),
        ),
      );
}
