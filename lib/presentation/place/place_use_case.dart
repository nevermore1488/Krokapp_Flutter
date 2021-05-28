import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';

class PlaceUseCase {
  CitiesRepository _citiesRepository;
  PointsRepository _pointsRepository;
  BuildContext _context;

  PlaceUseCase(
    this._citiesRepository,
    this._pointsRepository,
    this._context,
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

  Stream<String> getTitle(PlaceMode placeMode) {
    switch (placeMode.runtimeType) {
      case CitiesMode:
        return Future.value(AppLocalizations.of(_context)!.cities_title).asStream();

      case PointsMode:
        return _citiesRepository
            .getCityById((placeMode as PointsMode).cityId!)
            .map((event) => event.first.title);

      case DetailMode:
        return _pointsRepository
            .getPointById((placeMode as DetailMode).pointId)
            .map((event) => event.first.title);

      default:
        throw Exception("no such place mode");
    }
  }

  Stream<PlaceDetail> getPlaceDetail(int placeId) =>
      _pointsRepository.getPointById(placeId).map((event) => event.first);
}
