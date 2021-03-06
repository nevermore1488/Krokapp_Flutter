import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:krokapp_multiplatform/resources.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

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
        onHasData: (_) => GoogleMap(
          initialCameraPosition: _createDefaultCameraPosition(vm.startLocation),
          onMapCreated: (controller) => _onMapCreated(controller, vm),
          myLocationButtonEnabled: true,
          myLocationEnabled: vm.isShowCurrentLocation(),
          markers: _createMarkers(vm.markers),
          polylines: _createRoute(vm.route),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller, MapViewModel vm) async {
    LocationData? currentLocation = await vm.currentLocation?.getLocation();
    if (vm.isNeedMoveToCurrentLocation && currentLocation != null) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(currentLocation.latitude!, currentLocation.longitude!), _DEFAULT_ZOOM));
      vm.onMovedToCurrentLocation();
    }
  }

  Set<Marker> _createMarkers(List<MarkerInfo> markers) => markers
      .map(
        (e) => Marker(
          markerId: MarkerId(e.id.toString()),
          position: e.latLng,
          infoWindow: InfoWindow(title: e.title),
        ),
      )
      .toSet();

  Set<Polyline> _createRoute(List<LatLng> route) => [
        Polyline(
          polylineId: PolylineId("undefined"),
          points: route,
          color: Provider.of<Resources>(context).colorPrimary,
          width: 3,
        ),
      ].toSet();

  CameraPosition _createDefaultCameraPosition(LatLng location) =>
      CameraPosition(
        target: location,
        zoom: _DEFAULT_ZOOM,
      );

  @override
  void dispose() {
    Provider.of<MapViewModel>(context, listen: false).onViewDispose();
    super.dispose();
  }
}
