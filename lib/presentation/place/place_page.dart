import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_page.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_page.dart';

class PlacePage extends StatefulWidget {
  final PlaceType placeType;
  final Widget title;
  final extraId;
  final Widget? drawer;

  PlacePage({
    required this.placeType,
    required this.title,
    this.extraId,
    this.drawer,
  });

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  var _isFirstPage = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: widget.title,
          actions: [_createSwitchIcon()],
          brightness: Brightness.dark,
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _createCurrentPage(),
          transitionBuilder: _createCurrentSwitchAnimation,
        ),
        drawer: widget.drawer,
      );

  Widget _createSwitchIcon() => IconButton(
        icon: Icon(_isFirstPage ? Icons.map_outlined : Icons.list_alt),
        onPressed: _onSwitchIconClick,
        tooltip: "Switch mode",
      );

  void _onSwitchIconClick() {
    setState(() {
      _isFirstPage = !_isFirstPage;
    });
  }

  Widget _createCurrentPage() => _isFirstPage ? _createFirstPage() : _createSecondPage();

  Widget _createFirstPage() => PlaceListPage();

  Widget _createSecondPage() => MapPage();

  Widget _createCurrentSwitchAnimation(Widget child, Animation<double> animation) =>
      SlideTransition(
        child: child,
        position: Tween(
          begin: Offset(_isFirstPage ? -1.0 : 1.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation),
      );
}
