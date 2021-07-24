import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:krokapp_multiplatform/data/repositories/tags_repository.dart';

class ExcursionUseCase {
  TagsRepository _tagsRepository;

  ExcursionUseCase(
    this._tagsRepository,
  );

  Stream<List<Tag>> getTags() => _tagsRepository.getTags();
}
