import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/loading_data_use_case.dart';

class KrokAppViewModel {
  LoadingDataUseCase _loadingDataUseCase;

  KrokAppViewModel(
    this._loadingDataUseCase,
  );

  Stream<Locale> init(List<Locale> systemLocales) =>
      _loadingDataUseCase.loadData(systemLocales).asStream();
}
