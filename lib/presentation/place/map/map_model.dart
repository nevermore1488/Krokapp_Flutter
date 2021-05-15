import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/marker_info.dart';

class MapModel extends ChangeNotifier {
  static const _MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);

  List<MarkerInfo> markers= _createMarkers();
  List<LatLng> route = List.empty();
  LatLng startLocation = LatLng(0, 0);

  MapModel() {
    route = markers.map((e) => LatLng(e.lat, e.lng)).toList();
    startLocation = LatLng(markers.first.lat, markers.first.lng);
  }

  static List<MarkerInfo> _createMarkers() => List.generate(
        20,
        (index) => MarkerInfo(
          index.toString(),
          "The Place",
          _MINSK_RAILROAD_LOCATION.latitude + 0.01 * index,
          _MINSK_RAILROAD_LOCATION.longitude + 0.01 * index,
        ),
      );
}
