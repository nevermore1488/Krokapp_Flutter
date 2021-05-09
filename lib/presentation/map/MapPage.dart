import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/presentation/map/MarkerInfo.dart';

class MapPage extends StatelessWidget {
  static const MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);
  static const _DEFAULT_ZOOM = 11.0;

  final List<MarkerInfo> markers;

  MapPage({
    this.markers,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GoogleMap(
          initialCameraPosition: _createDefaultCameraPosition(_getStartLocation()),
          markers: _createMarkers(),
        ),
      );

  Set<Marker> _createMarkers() => markers
      .map(
        (e) => Marker(
            markerId: MarkerId(e.id.toString()),
            position: LatLng(e.lat, e.lng),
            infoWindow: InfoWindow(title: e.title)),
      )
      .toSet();

  CameraPosition _createDefaultCameraPosition(LatLng location) => CameraPosition(
        target: location,
        zoom: _DEFAULT_ZOOM,
      );

  LatLng _getStartLocation() {
    if (markers != null && markers.isNotEmpty) return LatLng(markers.first.lat, markers.first.lng);

    return MINSK_RAILROAD_LOCATION;
  }
}
