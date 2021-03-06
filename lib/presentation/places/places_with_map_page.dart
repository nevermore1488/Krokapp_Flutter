import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:krokapp_multiplatform/business/usecases/build_route_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/map/map_page.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:krokapp_multiplatform/presentation/places/place_item.dart';
import 'package:krokapp_multiplatform/presentation/places/place_map_view_model.dart';
import 'package:krokapp_multiplatform/presentation/places/places_view_model.dart';
import 'package:krokapp_multiplatform/resources.dart';
import 'package:krokapp_multiplatform/ui/player_view.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';

Widget createPlacesWithMapPageInProvider(
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
      child: PlacesWithMapPage(drawer: drawer),
    );

class PlacesWithMapPage extends StatelessWidget {
  final Widget? drawer;

  PlacesWithMapPage({
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    PlacesViewModel vm = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _getTitle(vm),
        actions: [_createSwitchIcon(vm)],
      ),
      body: Stack(
        children: [
          _createMapPage(context, vm),
          _createPlacesPage(vm),
        ],
      ),
      drawer: drawer,
    );
  }

  Widget _createPlacesPage(PlacesViewModel vm) => StreamBuilder<bool>(
        stream: vm.getIsShowPlaces(),
        builder: (context, snapshot) => SnapshotView<bool>(
          snapshot: snapshot,
          onHasData: (data) {
            if (!data) return SizedBox.shrink();

            if (vm.selectArgs.id == null)
              return _createPlaceListPage(vm);
            else
              return _createPlaceDetailPage(vm);
          },
        ),
      );

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
              onHasData: (data) {
                final _currentPageNotifier = ValueNotifier<int>(0);

                return ListView(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Stack(
                        children: [
                          PageView(
                            controller: PageController(),
                            children: data.images
                                .map((e) => Image.network(e))
                                .toList(),
                            onPageChanged: (int index) {
                              _currentPageNotifier.value = index;
                            },
                          ),
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CirclePageIndicator(
                                itemCount: data.images.length,
                                currentPageNotifier: _currentPageNotifier,
                                dotColor: Colors.white,
                                selectedDotColor:
                                    Provider.of<Resources>(context)
                                        .colorPrimary,
                                selectedSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: _createPlayerView(vm, data),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      child: HtmlWidget(data.text),
                    ),
                  ],
                );
              }),
        ),
      );

  Widget _createPlayerView(PlacesViewModel vm, PlaceDetail data) =>
      data.sound.isNotEmpty
          ? ChangeNotifierProvider(
              create: (context) => vm.getPlayerModel(data),
              child: PlayerView(),
            )
          : SizedBox.shrink();

  Widget _createMapPage(BuildContext context, PlacesViewModel vm) =>
      StreamBuilder<bool>(
        stream: vm.getIsShowMap(),
        builder: (context, snapshot) => SnapshotView<bool>(
          snapshot: snapshot,
          onHasData: (data) {
            if (!data) return SizedBox.shrink();

            return Provider<MapViewModel>(
              create: (_) => PlaceMapViewModel(
                vm.selectArgs,
                Provider.of(context),
                Provider.of<Resources>(context).isSetupExcursionOnPoints,
                Provider.of(context),
                BuildRouteUseCase(Provider.of(context)),
              ),
              child: MapPage(),
            );
          },
        ),
      );

  Widget _createSwitchIcon(PlacesViewModel vm) => IconButton(
        icon: StreamBuilder<bool>(
          stream: vm.getIsShowPlaces(),
          builder: (context, snapshot) => SnapshotView<bool>(
            snapshot: snapshot,
            onHasData: (data) =>
                Icon(data ? Icons.map_outlined : Icons.list_alt),
          ),
        ),
        onPressed: vm.onSwitchIconClicked,
        tooltip: "Switch mode",
      );

  Widget _getTitle(PlacesViewModel vm) => StreamBuilder<String>(
        stream: vm.getTitle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AutoSizeText(snapshot.data!, maxLines: 2);
          } else
            return SizedBox.shrink();
        },
      );
}
