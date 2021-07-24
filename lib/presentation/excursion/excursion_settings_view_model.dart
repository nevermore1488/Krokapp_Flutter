import 'package:krokapp_multiplatform/business/usecases/excursion_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/tag.dart';

class ExcursionSettingsViewModel {
  ExcursionUseCase _excursionUseCase;

  ExcursionSettingsViewModel(
    this._excursionUseCase,
  );

  Stream<List<Tag>> getTags() => _excursionUseCase.getTags();
}
