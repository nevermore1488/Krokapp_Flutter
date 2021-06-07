import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/map/map_page.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:krokapp_multiplatform/presentation/places/place_item.dart';
import 'package:krokapp_multiplatform/presentation/places/places_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

Widget createPlacesPageWithProvider(
  SelectArgs selectArgs,
  PlaceUseCase placeUseCase, {
  Widget? drawer,
}) =>
    Provider<PlacesViewModel>(
      create: (context) => PlacesViewModel(
        selectArgs,
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
    PlacesViewModel vm = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _getTitle(vm),
        actions: [_createSwitchIcon()],
        brightness: Brightness.dark,
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _createCurrentPage(vm, context),
        transitionBuilder: _createCurrentSwitchAnimation,
      ),
      drawer: widget.drawer,
    );
  }

  Widget _createCurrentPage(
    PlacesViewModel vm,
    BuildContext context,
  ) =>
      _isFirstPage ? _createFirstPage(vm) : _createSecondPage(vm.selectArgs);

  Widget _createFirstPage(
    PlacesViewModel vm,
  ) {
    if (vm.selectArgs.id == null)
      return _createPlaceListPage(vm);
    else
      return _createPlaceDetailPage(vm);
  }

  Widget _createPlaceListPage(PlacesViewModel vm) => Scaffold(
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

  Widget _createPlaceDetailPage(PlacesViewModel vm) => Scaffold(
        body: StreamBuilder<PlaceDetail>(
          stream: vm.getPlaceDetail(),
          builder: (context, snapshot) => SnapshotView<PlaceDetail>(
              snapshot: snapshot,
              onHasData: (data) => ListView(
                    children: [
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: PageView(
                          controller: PageController(),
                          children: data.images.map((e) => Image.network(e)).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: HtmlWidget(data.text),
                      ),
                    ],
                  )),
        ),
      );

  Widget _createSecondPage(SelectArgs selectArgs) => Provider<MapViewModel>(
        create: (_) => MapViewModel(
          selectArgs,
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

  Widget _getTitle(PlacesViewModel vm) => StreamBuilder<String>(
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
