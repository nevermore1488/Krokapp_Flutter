import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krokapp_multiplatform/data/place_type.dart';
import 'package:krokapp_multiplatform/presentation/navigation_menu_drawer.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        primaryColorBrightness: Brightness.dark,
      ),
      title: "KrokApp",
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => PlacePage(
              placeType: PlaceType.cities,
              title: Text("Cities"),
              drawer: NavigationMenuDrawer(),
            ),
      },
    );
  }
}
