import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/loading_data_use_case.dart';
import 'package:rxdart/rxdart.dart';

class KrokAppViewModel {
  LoadingDataUseCase _loadingDataUseCase;
  LanguageUseCase _languageUseCase;

  KrokAppViewModel(
    this._loadingDataUseCase,
    this._languageUseCase,
  );

  Stream<Locale> getLocale(List<Locale> systemLocales) => init(systemLocales)
      .asStream()
      .switchMap((value) => _languageUseCase.getCurrentLanguage())
      .map((event) => Locale(event.key));

  Future init(List<Locale> systemLocales) async {
    await _languageUseCase.setupLanguage(systemLocales);
    await _loadingDataUseCase.loadData();
  }
}
