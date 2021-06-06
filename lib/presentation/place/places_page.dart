import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/presentation/place/detail/place_detail_page.dart';
import 'package:krokapp_multiplatform/presentation/place/detail/place_detail_view_model.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_page.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_view_model.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_page.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_view_model.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/place_view_model.dart';
import 'package:provider/provider.dart';

Widget createPlacesPageWithProvider(
  PlaceMode placeMode,
  PlaceUseCase placeUseCase, {
  Widget? drawer,
}) =>
    Provider<PlaceViewModel>(
      create: (context) => PlaceViewModel(
        placeMode,
        placeUseCase,
        context,
      ),
      child: PlacesPage(drawer: drawer),
    );

class PlacesPage extends StatefulWidget {
  final Widget? drawer;

  PlacesPage({
    this.drawer,
  });

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  var _isFirstPage = true;

  @override
  Widget build(BuildContext context) {
    PlaceViewModel vm = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _getTitle(vm),
        actions: [_createSwitchIcon()],
        brightness: Brightness.dark,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _createCurrentPage(vm.placeMode, context),
        transitionBuilder: _createCurrentSwitchAnimation,
      ),
      drawer: widget.drawer,
    );
  }

  Widget _createCurrentPage(
    PlaceMode placeMode,
    BuildContext context,
  ) =>
      _isFirstPage ? _createFirstPage(placeMode, context) : _createSecondPage(placeMode, context);

  Widget _createFirstPage(
    PlaceMode placeMode,
    BuildContext context,
  ) {
    switch (placeMode.runtimeType) {
      case CitiesMode:
      case PointsMode:
        return Provider<PlaceListViewModel>(
          create: (_) => PlaceListViewModel(
            placeMode,
            Provider.of(context),
            context,
          ),
          child: PlaceListPage(),
        );
      case DetailMode:
        return Provider<PlaceDetailViewModel>(
          create: (_) => PlaceDetailViewModel(
            Provider.of(context),
            (placeMode as DetailMode).pointId,
          ),
          child: PlaceDetailPage(),
        );

      default:
        throw Exception("no such mode");
    }
  }

  Widget _createSecondPage(
    PlaceMode placeMode,
    BuildContext context,
  ) =>
      Provider<MapViewModel>(
        create: (_) => MapViewModel(
          placeMode,
          Provider.of(context),
          Provider.of(context),
        ),
        child: MapPage(),
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

  Widget _getTitle(PlaceViewModel vm) => StreamBuilder<String>(
        stream: vm.getTitle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AutoSizeText(snapshot.data!, maxLines: 2);
          } else
            return SizedBox.shrink();
        },
      );

  Widget _createCurrentSwitchAnimation(Widget child, Animation<double> animation) =>
      SlideTransition(
        child: child,
        position: Tween(
          begin: Offset(_isFirstPage ? -1.0 : 1.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation),
      );
}
