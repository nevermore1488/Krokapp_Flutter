import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';

class LanguageUseCase {
  LanguagesRepository _languagesRepository;

  LanguageUseCase(this._languagesRepository);

  Stream<Language?> getCurrentLanguage() => _languagesRepository.getCurrentLanguage();

  Future<void> applySystemLocales(List<Locale> systemLocales) async {
    Language? currentLanguage = await _languagesRepository.getCurrentLanguage().first;

    if (systemLocales.contains(currentLanguage?.key)) return;

    List<Language> languages = await _languagesRepository.loadLanguages();

    languages.sort(
      (l1, l2) =>
          systemLocales.indexWhere((e) => e.languageCode == l1.key) -
          systemLocales.indexWhere((e) => e.languageCode == l2.key),
    );

    _languagesRepository.setCurrentLanguage(languages.first);
  }
}
