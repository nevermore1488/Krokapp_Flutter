import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_item.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_use_case.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_view_model.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:provider/provider.dart';

class PlaceListPage extends StatelessWidget {
  final PlaceMode placeMode;
  late final PlaceListViewModel vm;

  PlaceListPage({
    required this.placeMode,
  });

  @override
  Widget build(BuildContext context) {
    vm = PlaceListViewModel(
      placeMode,
      PlaceListUseCase(Provider.of(context), Provider.of(context)),
      context,
    );
    return Scaffold(
      body: StreamBuilder<List<Place>>(
        stream: vm.places,
        builder: (context, placesSnap) {
          if (placesSnap.hasData) {
            return ListView(
              children: _createPlaceItems(placesSnap.data!),
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

  List<Widget> _createPlaceItems(List<Place> places) => places
      .map((e) => PlaceItem(
            place: e,
            onItemClick: (_, place) => vm.onPlaceClick(place),
            onFavoriteClick: (_, place) => vm.onPlaceFavoriteClick(place),
          ))
      .toList();
}
