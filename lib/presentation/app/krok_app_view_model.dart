import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/locale_use_case.dart';

class KrokAppViewModel {
  LocaleUseCase _localeUseCase;

  KrokAppViewModel(this._localeUseCase);

  late Locale selectedLocale;

  Future<bool> initApp() async {
    selectedLocale = await _localeUseCase.getLocale(WidgetsBinding.instance!.window.locales);
    return true;
  }
}
