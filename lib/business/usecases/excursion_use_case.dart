import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/repositories/excursion_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

class ExcursionModel {
  List<MarkerInfo> markers;
  List<LatLng> route;

  ExcursionModel(
    this.markers,
    this.route,
  );
}

class ExcursionUseCase {
  PointsRepository _pointsRepository;
  ExcursionRepository _excursionRepository;

  ExcursionUseCase(
    this._pointsRepository,
    this._excursionRepository,
  );

  Stream<ExcursionModel> getExcursionModel(LatLng currentLocation) =>
      _pointsRepository
          .getPointsBySelectArgs(
        SelectArgs(placeType: PlaceType.point, isExcursion: true),
      )
          .map((event) {
        final markers = event.map((e) => e.toMarker()).toList();

        return ExcursionModel(
          markers,
          markers.map((e) => e.latLng).toList(),
        );
      });
}
