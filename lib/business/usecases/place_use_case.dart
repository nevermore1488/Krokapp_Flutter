import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';

class PlaceUseCase {
  CitiesRepository _citiesRepository;
  PointsRepository _pointsRepository;

  PlaceUseCase(
    this._citiesRepository,
    this._pointsRepository,
  );

  Stream<List<Place>> getCities() => _citiesRepository.getCities();

  Stream<List<Place>> getCityById(int cityId) => _citiesRepository.getCityById(cityId);

  Stream<List<Place>> getPointsOfCity(int cityId) => _pointsRepository.getPointsOfCity(cityId);

  Stream<List<Place>> getPoints() => _pointsRepository.getPoints();

  Stream<List<Place>> getPointById(int pointId) => _pointsRepository.getPointById(pointId);

  Stream<List<Place>> getFavorites() => _pointsRepository.getFavorites();

  Stream<List<Place>> getVisited() => _pointsRepository.getVisited();

  Stream<PlaceDetail> getPlaceDetail(int placeId) =>
      _pointsRepository.getPointById(placeId).map((event) => event.first);

  Future<void> savePlaceFeature(PlaceFeature placeFeature) =>
      _pointsRepository.savePlaceFeature(placeFeature);

  Future<void> loadPlacesIfNeeded() async {
    var citiesFuture = _citiesRepository.loadCitiesIfNeeded();
    var pointsFuture = _pointsRepository.loadPointsIfNeeded();
    await citiesFuture;
    await pointsFuture;
  }
}
