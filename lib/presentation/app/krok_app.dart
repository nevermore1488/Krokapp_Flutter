import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/presentation/about_us_page.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app_view_model.dart';
import 'package:krokapp_multiplatform/presentation/main/navigation_menu_drawer.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/places_page.dart';
import 'package:krokapp_multiplatform/ui/rotate_container.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    KrokAppViewModel vm = Provider.of(context);
    vm.applySystemLocales(WidgetsBinding.instance!.window.locales);

    return StreamBuilder<Locale>(
      stream: vm.getCurrentLocale(),
      builder: (context, snapshot) => SnapshotView<Locale>(
        snapshot: snapshot,
        onHasData: (value) => _createMainScreen(value),
        onLoading: createSplashScreen,
      ),
    );
  }

  Widget _createMainScreen(Locale selectedLocale) => Container(
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: Colors.orange,
            primaryColorBrightness: Brightness.dark,
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => createPlacesPageWithProvider(
                  CitiesMode(),
                  Provider.of(context),
                  drawer: NavigationMenuDrawer(),
                ),
            '/about_us': (BuildContext context) => AboutUsPage(),
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
