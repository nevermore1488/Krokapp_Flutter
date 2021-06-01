import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/presentation/app/navigation_menu_drawer.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';

class KrokApp extends StatelessWidget {
  final Locale selectedLocale;

  KrokApp(this.selectedLocale);

  @override
  Widget build(BuildContext context) => MaterialApp(
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
}
