import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';

class LanguageUseCase {
  LanguagesRepository _languagesRepository;

  LanguageUseCase(this._languagesRepository);

  Stream<Language?> getCurrentLanguage() => _languagesRepository.getCurrentLanguage();

  Future<void> applySystemLocales(List<Locale> systemLocales) async {
    Language? currentLanguage = await _languagesRepository
        .getCurrentLanguage()
        .first;

    if (systemLocales.contains(currentLanguage?.key)) return;

    List<Language> languages = await _languagesRepository.loadLanguages();

    Locale? selectedLocale = systemLocales
        .firstWhere((locale) => languages.any((lang) => lang.key == locale.languageCode),
        orElse: () => Locale("en"));

    Language selectedLanguage = languages.firstWhere((lang) => lang.key == selectedLocale.languageCode);

    _languagesRepository.setCurrentLanguage(selectedLanguage);
  }
}
