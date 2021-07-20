import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';
import 'package:krokapp_multiplatform/utils//extentions.dart';

class LanguageUseCase {
  LanguagesRepository _languagesRepository;

  LanguageUseCase(this._languagesRepository);

  Stream<List<Language>> getLanguages() => _languagesRepository.getLanguages();

  Stream<Language> getCurrentLanguage() =>
      _languagesRepository.getCurrentLanguage().whereNotNull();

  Future<void> setCurrentLanguage(Language language) =>
      _languagesRepository.setCurrentLanguage(language);
}
