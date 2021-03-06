import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

class PlaceUseCase {
  CitiesRepository _citiesRepository;
  PointsRepository _pointsRepository;

  PlaceUseCase(
    this._citiesRepository,
    this._pointsRepository,
  );

  Stream<List<Place>> getPlacesBySelectArgs(
    SelectArgs selectArgs,
  ) =>
      selectArgs.placeType == PlaceType.city
          ? _citiesRepository.getCitiesBySelectArgs(selectArgs)
          : _pointsRepository.getPointsBySelectArgs(selectArgs);

  Future<void> savePointFeature(PlaceFeature placeFeature) =>
      _pointsRepository.savePointFeature(placeFeature);
}
