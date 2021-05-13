import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/presentation/map/MapModel.dart';
import 'package:krokapp_multiplatform/presentation/map/MapPage.dart';
import 'package:provider/provider.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange, primaryColorBrightness: Brightness.dark),
      title: "KrokApp",
      /*home: PlaceListPage(
        _createPlaces(),
      ),*/
      home: Scaffold(
        appBar: AppBar(title: Text("KrokApp")),
        body: ChangeNotifierProvider(
          create: (context) => MapModel(),
          child: MapPage(),
        ),
      ),
    );
  }
}
