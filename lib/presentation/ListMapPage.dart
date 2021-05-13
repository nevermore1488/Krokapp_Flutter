import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/presentation/SwitchablePage.dart';
import 'package:krokapp_multiplatform/presentation/list/PlaceListModel.dart';
import 'package:krokapp_multiplatform/presentation/list/PlaceListPage.dart';
import 'package:krokapp_multiplatform/presentation/map/MapModel.dart';
import 'package:krokapp_multiplatform/presentation/map/MapPage.dart';
import 'package:provider/provider.dart';

class ListMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SwitchablePage(
        title: Text("KrokApp"),
        firstPage: ChangeNotifierProvider(
          create: (context) => PlaceListModel(),
          child: PlaceListPage(),
        ),
        secondPage: ChangeNotifierProvider(
          create: (context) => MapModel(),
          child: MapPage(),
        ),
        firstIcon: Icon(Icons.map_outlined),
        secondIcon: Icon(Icons.list_alt),
      );
}
