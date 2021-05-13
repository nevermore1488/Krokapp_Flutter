import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/presentation/ListMapPage.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange, primaryColorBrightness: Brightness.dark),
      title: "KrokApp",
      /*home: PlaceListPage(
        _createPlaces(),
      ),*/
      home: ListMapPage(),
    );
  }
}
