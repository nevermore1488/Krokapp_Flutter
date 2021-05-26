import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_item.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/place_view_model.dart';
import 'package:provider/provider.dart';

class PlaceListPage extends StatelessWidget {
  final PlaceMode placeMode;

  PlaceListPage({
    required this.placeMode,
  });

  @override
  Widget build(BuildContext context) {
    PlaceListViewModel vm = Provider.of(context);

    return Scaffold(
      body: StreamBuilder<List<Place>>(
        stream: vm.getPlaces(),
        builder: (context, placesSnap) {
          if (placesSnap.hasData) {
            return ListView(
              children: _createPlaceItems(vm, placesSnap.data!),
              padding: EdgeInsets.only(
                top: 8,
                bottom: 32,
              ),
            );
          } else if (placesSnap.hasError) {
            return Center(
              child: Text(placesSnap.error.toString()),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }

  List<Widget> _createPlaceItems(PlaceListViewModel vm, List<Place> places) => places
      .map((e) => PlaceItem(
            place: e,
            onItemClick: (_, place) => vm.onPlaceClick(place),
            onFavoriteClick: (_, place) => vm.onPlaceFavoriteClick(place),
          ))
      .toList();
}
