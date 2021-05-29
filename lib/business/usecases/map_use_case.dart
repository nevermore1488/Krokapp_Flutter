import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_model.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';

const _MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);

class MapUseCase {
  PointsRepository _pointsRepository;

  MapUseCase(
    this._pointsRepository,
  );

  Stream<MapModel> getMapModel(PlaceMode placeMode) {
    Stream<List<Place>> places;
    switch (placeMode.runtimeType) {
      case CitiesMode:
        {
          places = _pointsRepository.getPoints();
          break;
        }
      case PointsMode:
        {
          places = _pointsRepository.getPointsOfCity((placeMode as PointsMode).cityId!);
          break;
        }
      case DetailMode:
        {
          places = _pointsRepository.getPointById((placeMode as DetailMode).pointId);
          break;
        }
      default:
        throw Exception("no such place mode");
    }
    return places.map((event) => MapModel(
          markers: event.map((e) => e.toMarker()).toList(),
          route: List.empty(),
          startLocation:
              event.isNotEmpty ? event.first.toMarker().latLng : _MINSK_RAILROAD_LOCATION,
        ));
  }
}
