import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';

class PlaceUseCase {
  CitiesRepository _citiesRepository;
  PointsRepository _pointsRepository;

  PlaceUseCase(
    this._citiesRepository,
    this._pointsRepository,
  );

  Stream<List<Place>> getPlaces(PlaceMode placeMode) {
    switch (placeMode.runtimeType) {
      case CitiesMode:
        return _citiesRepository.getCities();

      case PointsMode:
        return _pointsRepository.getPointsOfCity((placeMode as PointsMode).cityId!);

      case DetailMode:
        return Future<List<Place>>(() => List.empty()).asStream();

      default:
        throw Exception("no such place mode");
    }
  }

  Stream<PlaceDetail> getPlaceDetail(int placeId) =>
      _pointsRepository.getPointById(placeId).map((event) => event.first);
}
