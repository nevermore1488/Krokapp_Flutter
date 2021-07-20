import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/data/repositories/cities_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/points_repository.dart';
import 'package:krokapp_multiplatform/data/repositories/tags_repository.dart';

class LoadingDataUseCase {
  LanguagesRepository _languagesRepository;
  CitiesRepository _citiesRepository;
  PointsRepository _pointsRepository;
  TagsRepository _tagsRepository;

  LoadingDataUseCase(
    this._languagesRepository,
    this._citiesRepository,
    this._pointsRepository,
    this._tagsRepository,
  );

  Future<Locale> loadData(List<Locale> systemLocales) async {
    Locale currentLocale = await _applySystemLocales(systemLocales);

    var citiesFuture = _citiesRepository.loadCities();
    var pointsFuture = _pointsRepository.loadPoints();
    var tagsFuture = _tagsRepository.loadTags();

    await citiesFuture;
    await pointsFuture;
    await tagsFuture;

    return currentLocale;
  }

  Future<Locale> _applySystemLocales(List<Locale> systemLocales) async {
    Language? currentLanguage =
        await _languagesRepository.getCurrentLanguage().first;

    if (currentLanguage != null)
      return systemLocales.firstWhere(
          (element) => element.languageCode == currentLanguage!.key);

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
