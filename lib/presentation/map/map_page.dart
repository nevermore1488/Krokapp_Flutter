import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const _DEFAULT_ZOOM = 11.0;

  @override
  Widget build(BuildContext context) {
    MapViewModel vm = Provider.of(context);
    vm.onViewInit();

    return StreamBuilder(
      stream: vm.onViewUpdate,
      builder: (context, snapshot) => SnapshotView(
        snapshot: snapshot,
        onHasData: (_) => YandexMap(
          onMapCreated: (controller) => _onMapCreated(controller, vm),
          mapObjects: _createMarkers(vm.markers),
        ),
      ),
    );
  }

  void _onMapCreated(YandexMapController controller, MapViewModel vm) async {
    LocationData? currentLocation = await vm.currentLocation?.getLocation();
    if (vm.isNeedMoveToCurrentLocation && currentLocation != null) {
      controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: Point(
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!,
            ),
            zoom: _DEFAULT_ZOOM,
          ),
        ),
      );
      vm.onMovedToCurrentLocation();
    }
  }

  List<MapObject> _createMarkers(List<MarkerInfo> markers) => markers
      .map(
        (e) => Placemark(
          mapId: MapObjectId(e.toString()),
          point: Point(
            latitude: e.latLng.lat,
            longitude: e.latLng.lng
          ),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/icons/krok_icon.png')
          ))
        ),
      )
      .toList();

/*  Set<Polyline> _createRoute(List<Point> route) => [
        Polyline(
          polylineId: PolylineId("undefined"),
          points: route,
          color: Provider.of<Resources>(context).colorPrimary,
          width: 3,
        ),
      ].toSet();*/

  CameraPosition _createDefaultCameraPosition(Point location) => CameraPosition(
        target: location,
        zoom: _DEFAULT_ZOOM,
      );

  @override
  void dispose() {
    Provider.of<MapViewModel>(context, listen: false).onViewDispose();
    super.dispose();
  }
}
