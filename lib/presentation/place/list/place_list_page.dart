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
                  children: data
                      .map((e) => PlaceItem(
                            place: e,
                          ))
                      .toList(),
                  padding: EdgeInsets.only(
                    bottom: 32,
                  ),
                )),
      ),
    );
  }
}
