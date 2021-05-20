import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/cities_dao.dart';
import 'package:krokapp_multiplatform/data/db/db.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_item.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<Place>>(
          future: CitiesRepository(CitiesApiImpl(), CitiesDaoImpl(createDb())).getCities(),
          builder: (context, placesSnap) {
            if (placesSnap.hasData) {
              return ListView(
                children: _createPlaceItems(placesSnap.data!),
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 32,
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      );

  List<Widget> _createPlaceItems(List<Place> places) => places
      .map((e) => PlaceItem(
            place: e,
            onItemClick: _push,
            onFavoriteClick: (BuildContext, Place) => {},
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
