import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:rxdart/rxdart.dart';

class KrokAppViewModel {
  LanguageUseCase _langageUseCase;
  PlaceUseCase _placeUseCase;

  var _isAppInited = PublishSubject();

  KrokAppViewModel(
    this._langageUseCase,
    this._placeUseCase,
  );

  Stream<Locale> getCurrentLocale() => _isAppInited.stream
      .switchMap((value) => _langageUseCase.getCurrentLanguage().map((event) => Locale(event.key)));

  void applySystemLocales(List<Locale> systemLocales) async {
    await _langageUseCase.applySystemLocales(systemLocales);
    await _placeUseCase.loadPlaces();
    _isAppInited.add(true);
  }
}
