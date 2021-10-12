import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/tags_repository.dart';

class LoadingDataUseCase {
  CitiesRepository _citiesRepository;
  PointsRepository _pointsRepository;
  TagsRepository _tagsRepository;

  LoadingDataUseCase(
    this._citiesRepository,
    this._pointsRepository,
    this._tagsRepository,
  );

  Future loadData() async {
    var citiesFuture = _citiesRepository.loadCities();
    var pointsFuture = _pointsRepository.loadPoints();
    var tagsFuture = _tagsRepository.loadTags();

    await citiesFuture;
    await pointsFuture;
    await tagsFuture;

    return;
  }
}
