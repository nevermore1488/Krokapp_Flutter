import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/Place.dart';
import 'package:krokapp_multiplatform/presentation/list/PlaceItem.dart';

class PlaceListPage extends StatelessWidget {
  final List<Place> _items;
  final Function(Place) onPlaceClick;
  final Function(Place) onPlaceFavoriteClick;

  PlaceListPage(
    this._items, {
    this.onPlaceClick,
    this.onPlaceFavoriteClick,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: _createPlaceItems(),
          padding: EdgeInsets.only(bottom: 32),
        ),
      );

  List<Widget> _createPlaceItems() =>
      _items.map((e) => PlaceItem(e, onPlaceClick, onPlaceClick)).toList();
}
