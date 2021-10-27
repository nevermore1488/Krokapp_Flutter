import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/business/usecases/excursion_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/map/excursion_path_creator.dart';
import 'package:krokapp_multiplatform/presentation/about_us_page.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/presentation/app/navigation_menu_drawer.dart';
import 'package:krokapp_multiplatform/presentation/excursion/excursion_page.dart';
import 'package:krokapp_multiplatform/presentation/excursion/excursion_settings_page.dart';
import 'package:krokapp_multiplatform/presentation/excursion/excursion_view_model.dart';
import 'package:krokapp_multiplatform/presentation/places/places_with_map_page.dart';
import 'package:krokapp_multiplatform/resources.dart';
import 'package:krokapp_multiplatform/ui/rotate_container.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class KrokAppRoutes {
  static const HOME = "/";
  static const ABOUT_US = "/about_us";
  static const FAVORITES = "/favorites";
  static const VISITED = "/visited";
  static const EXCURSION = "/excursion";
  static const EXCURSION_SETTINGS = "/excursion_settings";
}

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder<Locale>(
        stream: Provider.of<KrokAppViewModel>(context)
            .getLocale((WidgetsBinding.instance!.window.locales)),
        builder: (context, snapshot) => SnapshotView<Locale>(
          snapshot: snapshot,
          onHasData: (value) => _createMainScreen(context, value),
          onLoading: createSplashScreen,
        ),
      );

  Widget _createMainScreen(BuildContext context, Locale selectedLocale) =>
      Container(
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Resources.COLOR_PRIMARY,
              primaryColorBrightness: Brightness.dark,
              appBarTheme: AppBarTheme(
                color: Resources.COLOR_PRIMARY,
                brightness: Brightness.dark,
              )),
          initialRoute: KrokAppRoutes.HOME,
          routes: {
            KrokAppRoutes.HOME: (BuildContext context) =>
                createPlacesWithMapPageInProvider(
                  SelectArgs(placeType: PlaceType.city),
                  Provider.of(context),
                  drawer: NavigationMenuDrawer(),
                ),
            KrokAppRoutes.EXCURSION_SETTINGS: (BuildContext context) =>
                ExcursionSettingsPage(),
            KrokAppRoutes.EXCURSION: (BuildContext context) =>
                Provider<ExcursionViewModel>(
                  create: (_) => ExcursionViewModel(
                    ExcursionUseCase(Provider.of(context), Provider.of(context),
                        ExcursionPathCreator()),
                    context,
                    Provider.of(context),
                  ),
                  child: ExcursionPage(),
                ),
            KrokAppRoutes.ABOUT_US: (BuildContext context) => AboutUsPage(),
            KrokAppRoutes.FAVORITES: (BuildContext context) =>
                createPlacesWithMapPageInProvider(
                  SelectArgs(
                    placeType: PlaceType.point,
                    isFavorite: true,
                  ),
                  Provider.of(context),
                ),
            KrokAppRoutes.VISITED: (BuildContext context) =>
                createPlacesWithMapPageInProvider(
                  SelectArgs(
                    placeType: PlaceType.point,
                    isVisited: true,
                  ),
                  Provider.of(context),
                ),
          },
          locale: selectedLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

  static Widget createSplashScreen() => MaterialApp(
        home: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: RotateContainer(
            child: SizedBox(
              width: 160,
              height: 160,
              child: Image(image: AssetImage('drawables/krok_icon.png')),
            ),
          ),
        ),
      );
}
