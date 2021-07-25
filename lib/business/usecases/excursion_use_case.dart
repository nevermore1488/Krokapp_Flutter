import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:krokapp_multiplatform/data/repositories/excursion_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/tags_repository.dart';

class ExcursionUseCase {
  TagsRepository _tagsRepository;
  ExcursionRepository _excursionRepository;

  ExcursionUseCase(
    this._tagsRepository,
    this._excursionRepository,
  );

  Stream<List<Tag>> getTags() => _tagsRepository.getTags();

  void onTagCheckChanged(Tag tag) {
    _tagsRepository.saveTagCheckState(tag.id, !tag.isChecked);
  }

  int getExcursionTimeInMinutes() {
    return _excursionRepository.getExcursionTimeInMinutes();
  }

  Future<bool> setExcursionTime(int timeInMinutes) {
    return _excursionRepository.setExcursionTime(timeInMinutes);
  }
}
