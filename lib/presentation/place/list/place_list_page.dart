import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_item.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PlaceListViewModel vm = Provider.of(context);

    return Scaffold(
      body: StreamBuilder<List<Place>>(
        stream: vm.getPlaces(),
        builder: (context, snapshot) => SnapshotView<List<Place>>(
            snapshot: snapshot,
            onHasData: (data) => ListView(
                  children: _createPlaceItems(vm, data),
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 32,
                  ),
                )),
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
