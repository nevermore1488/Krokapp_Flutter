import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/place/detail/place_detail_page.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_page.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_page.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_use_case.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/place_use_case.dart';
import 'package:krokapp_multiplatform/presentation/place/place_view_model.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatefulWidget {
  final PlaceMode placeMode;
  final Widget? drawer;

  PlacePage({
    required this.placeMode,
    this.drawer,
  });

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  var _isFirstPage = true;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ProxyProvider2<CitiesRepository, PointsRepository, PlaceViewModel>(
            update: (context, cityRep, pointsRep, previous) => PlaceViewModel(
              widget.placeMode,
              PlaceUseCase(cityRep, pointsRep),
              MapUseCase(pointsRep),
              context,
            ),
          ),
          ProxyProvider<PlaceViewModel, PlaceListViewModel>(
            update: (_, value, __) => value,
          ),
          ProxyProvider<PlaceViewModel, MapViewModel>(
            update: (_, value, __) => value,
          ),
          ProxyProvider<PlaceViewModel, DetailViewModel>(
            update: (_, value, __) => value,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: _getTitle(),
            actions: [_createSwitchIcon()],
            brightness: Brightness.dark,
          ),
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _createCurrentPage(),
            transitionBuilder: _createCurrentSwitchAnimation,
          ),
          drawer: widget.drawer,
        ),
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

  Widget _getTitle() {
    switch (widget.placeMode.runtimeType) {
      case CitiesMode:
        return Text("Cities");
      case PointsMode:
        return Text("Points");
      case DetailMode:
        return Text("Detailed");
      default:
        throw Exception("no such mode");
    }
  }

  Widget _createCurrentPage() => _isFirstPage ? _createFirstPage() : _createSecondPage();

  Widget _createFirstPage() {
    switch (widget.placeMode.runtimeType) {
      case CitiesMode:
      case PointsMode:
        return PlaceListPage(placeMode: widget.placeMode);

      case DetailMode:
        return PlaceDetailPage(placeId: (widget.placeMode as DetailMode).pointId);

      default:
        throw Exception("no such mode");
    }
  }

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
