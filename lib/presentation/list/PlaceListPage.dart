import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/presentation/list/PlaceItem.dart';
import 'package:provider/provider.dart';

import 'PlaceListModel.dart';

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<PlaceListModel>(
        builder: (context, model, child) => Scaffold(
          body: ListView(
            children: _createPlaceItems(model),
            padding: EdgeInsets.only(bottom: 32),
          ),
        ),
      );

  List<Widget> _createPlaceItems(PlaceListModel model) => model.places
      .map((e) => PlaceItem(e, model.onPlaceFavoriteClick, model.onPlaceClick))
      .toList();
}
