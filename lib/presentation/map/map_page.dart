import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/presentation/map/map_model.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  static const _DEFAULT_ZOOM = 11.0;

  @override
  Widget build(BuildContext context) {
    MapViewModel vm = Provider.of(context);
    return StreamBuilder<MapModel>(
      stream: vm.getMapModel(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var model = snapshot.data!;

          return GoogleMap(
            initialCameraPosition: _createDefaultCameraPosition(model.startLocation),
            markers: _createMarkers(model.markers),
            polylines: _createRoute(model.route),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
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
            polylineId: PolylineId("undefined"), points: route, color: Colors.orange, width: 5),
      ].toSet();

  CameraPosition _createDefaultCameraPosition(LatLng location) => CameraPosition(
        target: location,
        zoom: _DEFAULT_ZOOM,
      );
}
