import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/marker_info.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_model.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  static const _DEFAULT_ZOOM = 11.0;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<MapModel>(
        create: (context) => MapModel(),
        child: Consumer<MapModel>(
          builder: (context, model, child) => GoogleMap(
            initialCameraPosition: _createDefaultCameraPosition(model.startLocation),
            markers: _createMarkers(model.markers),
            polylines: _createRoute(model.route),
          ),
        ),
      );

  Set<Marker> _createMarkers(List<MarkerInfo> markers) => markers
      .map(
        (e) => Marker(
            markerId: MarkerId(e.id.toString()),
            position: LatLng(e.lat, e.lng),
            infoWindow: InfoWindow(title: e.title)),
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
