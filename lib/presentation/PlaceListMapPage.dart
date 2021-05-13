import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/presentation/list/PlaceListModel.dart';
import 'package:krokapp_multiplatform/presentation/list/PlaceListPage.dart';
import 'package:krokapp_multiplatform/presentation/map/MapModel.dart';
import 'package:krokapp_multiplatform/presentation/map/MapPage.dart';
import 'package:provider/provider.dart';

class PlaceListMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlaceListMapPageState();
}

class _PlaceListMapPageState extends State<PlaceListMapPage> {
  var _isPlaceList = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("KrokApp"),
          actions: [_createSwitchIcon()],
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 1000),
          child: _createCurrentPage(),
          transitionBuilder: _createCurrentSwitchAnimation,
        ),
      );

  Widget _createSwitchIcon() => IconButton(
        icon: Icon(
          _isPlaceList ? Icons.map_outlined : Icons.list_alt,
        ),
        onPressed: _onSwitchIconClick,
      );

  void _onSwitchIconClick() {
    setState(() {
      _isPlaceList = !_isPlaceList;
    });
  }

  Widget _createCurrentPage() => _isPlaceList
      ? ChangeNotifierProvider(
          create: (context) => PlaceListModel(),
          child: PlaceListPage(),
        )
      : ChangeNotifierProvider(
          create: (context) => MapModel(),
          child: MapPage(),
        );

  Widget _createCurrentSwitchAnimation(Widget child, Animation<double> animation) =>
      SlideTransition(
        child: child,
        position: Tween(
          begin: Offset(_isPlaceList ? -1.0 : 1.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation),
      );
}
