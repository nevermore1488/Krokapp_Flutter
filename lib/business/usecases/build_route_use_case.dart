import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/repositories/google_map_repository.dart';

class BuildRouteUseCase {
  GoogleMapRepository _googleMapRepository;

  BuildRouteUseCase(
    this._googleMapRepository,
  );

  Future<List<LatLng>> invoke(List<LatLng> points) =>
      _googleMapRepository.buildRouteBetweenPoints(points);
}
