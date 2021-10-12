import 'package:flutter/material.dart';
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

  Future<Locale> setupLanguage(List<Locale> systemLocales) async {
    Language? currentLanguage =
    await _languagesRepository.getCurrentLanguage().first;

    if (currentLanguage != null)
      return Locale(currentLanguage.key);

    List<Language> languages = await _languagesRepository.loadLanguages();

    Locale selectedLocale = systemLocales.firstWhere(
            (locale) => languages.any((lang) => lang.key == locale.languageCode),
        orElse: () => Locale("en"));

    currentLanguage =
        languages.firstWhere((lang) => lang.key == selectedLocale.languageCode);

    await _languagesRepository.setCurrentLanguage(currentLanguage);

    return selectedLocale;
  }
}
