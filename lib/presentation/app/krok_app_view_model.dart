import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';

class KrokAppViewModel {
  LanguageUseCase _localeUseCase;

  KrokAppViewModel(this._localeUseCase);

  Stream<Locale> getCurrentLocale() =>
      _localeUseCase.getCurrentLanguage().map((event) => Locale(event.key));

  void applySystemLocales(List<Locale> systemLocales) =>
      _localeUseCase.applySystemLocales(systemLocales);
}
