import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/about_us_page.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/presentation/main/navigation_menu_drawer.dart';
import 'package:krokapp_multiplatform/presentation/places/places_with_map_page.dart';
import 'package:krokapp_multiplatform/resources.dart';
import 'package:krokapp_multiplatform/ui/rotate_container.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder<Locale>(
        stream: Provider.of<KrokAppViewModel>(context)
            .init((WidgetsBinding.instance!.window.locales)),
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
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Resources.COLOR_TEXT,
                ),
            primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
                  bodyColor: Resources.COLOR_TEXT_PRIMARY,
                ),
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Resources.COLOR_ICON,
                ),
            primaryIconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Resources.COLOR_ICON_PRIMARY,
                ),
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => createPlacesWithMapPageInProvider(
                  SelectArgs(placeType: PlaceType.city),
                  Provider.of(context),
                  drawer: NavigationMenuDrawer(),
                ),
            '/about_us': (BuildContext context) => AboutUsPage(),
            '/favorites': (BuildContext context) =>
                createPlacesWithMapPageInProvider(
                  SelectArgs(
                    placeType: PlaceType.point,
                    isFavorite: true,
                  ),
                  Provider.of(context),
                ),
            '/visited': (BuildContext context) =>
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
          color: Resources.COLOR_PRIMARY,
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
