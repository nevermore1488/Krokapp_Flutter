import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_item.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';
import 'package:provider/provider.dart';

import 'place_list_model.dart';

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => PlaceListModel(),
        child: Consumer<PlaceListModel>(
          builder: (context, model, child) => Scaffold(
            body: ListView(
              children: _createPlaceItems(model),
              padding: EdgeInsets.only(bottom: 32),
            ),
          ),
        ),
      );

  List<Widget> _createPlaceItems(PlaceListModel model) => model.places
      .map((e) => PlaceItem(
            place: e,
            onItemClick: _push,
            onFavoriteClick: model.onPlaceClick,
          ))
      .toList();

  void _push(BuildContext context, Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlacePage(
                placeType: PlaceType.points,
                title: Text(place.title),
              )),
    );
  }
}
