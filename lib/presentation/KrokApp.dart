import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/Place.dart';
import 'package:krokapp_multiplatform/presentation/map/MapPage.dart';
import 'package:krokapp_multiplatform/presentation/map/MarkerInfo.dart';

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
        body: MapPage(
          markers: _createPlaces()
              .map((e) => MarkerInfo(e.id.toString(), e.title, e.lat, e.lng))
              .toList(),
        ),
      ),
    );
  }

  List<Place> _createPlaces() => List.generate(
        20,
        (index) => Place(
          index,
          "The Place",
          "https://krokapp.by/media/place_logo/54b818aa-f116-4610-ae4a-e625c56c426f.png",
          true,
          false,
          MapPage.MINSK_RAILROAD_LOCATION.latitude + 0.01 * index,
          MapPage.MINSK_RAILROAD_LOCATION.longitude + 0.01 * index,
        ),
      );
}
