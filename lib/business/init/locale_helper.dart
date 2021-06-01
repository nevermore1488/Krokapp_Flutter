import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';

class LocaleHelper {
  LanguagesRepository _languagesRepository;

  LocaleHelper(this._languagesRepository);

  Future<Locale> getLocale(List<Locale> systemLocales) async {
    List<LanguageTable> languages = await _languagesRepository.getLanguages().first;
    int? langId = await _languagesRepository.getCurrentLanguageId();

    if (langId == null) {
      List<String> langKeys = languages.map((e) => e.key).toList();
      Locale? selectedLocale;

      for (Locale locale in systemLocales) {
        if (langKeys.contains(locale.languageCode)) {
          selectedLocale = locale;
          break;
        }
      }

      String langKey = selectedLocale?.languageCode ?? langKeys.first;
      langId = languages.firstWhere((element) => element.key == langKey).id;
      await _languagesRepository.setCurrentLanguageId(langId);
    }

    LanguageTable lang = languages.firstWhere((element) => element.id == langId);
    return Locale(lang.key);
  }
}
