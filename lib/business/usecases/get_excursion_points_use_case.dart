import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/repositories/excursion_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/map/excursion_path_creator.dart';
import 'package:rxdart/rxdart.dart';

class GetExcursionPointsUseCase {
  PointsRepository _pointsRepository;
  ExcursionRepository _excursionRepository;
  ExcursionPathCreator _excursionPathCreator;

  GetExcursionPointsUseCase(
    this._pointsRepository,
    this._excursionRepository,
    this._excursionPathCreator,
  );

  Stream<List<MarkerInfo>> invoke(LatLng currentLocation) =>
      _pointsRepository
          .getPointsBySelectArgs(
            SelectArgs(placeType: PlaceType.point, isExcursion: true),
          )
          .cast<List<Place>>()
          .switchMap(
            (points) => _excursionRepository.onExcursionTimeChanged().map(
                  (timeInMinutes) => _excursionPathCreator.createPath(
                      _timeInMinutesToPowerLatLng(timeInMinutes),
                      currentLocation,
                      points),
                ),
          )
          .map((event) => event.map((e) => e.toMarker()).toList());

  double _timeInMinutesToPowerLatLng(int timeInMinutes) =>
      (0.05 * timeInMinutes) / 60.0;
}
