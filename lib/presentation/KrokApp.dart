import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/Place.dart';
import 'package:krokapp_multiplatform/ui/list/ListPage.dart';
import 'package:krokapp_multiplatform/ui/list/items/PlaceItem.dart';

class KrokApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.orange, primaryColorBrightness: Brightness.dark),
      home: ListPage(
        _createPlaceItems(),
        appBar: AppBar(title: Text("The Places")),
      ),
    );
  }

  List<Widget> _createPlaceItems() => List.generate(
        20,
        (index) => Place(
          index,
          "The Place",
          "https://krokapp.by/media/place_logo/54b818aa-f116-4610-ae4a-e625c56c426f.png",
          true,
          false,
        ),
      ).map((e) => PlaceItem(e, (Place) => {}, (Place) => {})).toList();
}
