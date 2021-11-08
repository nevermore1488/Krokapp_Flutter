import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/build_route_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/get_excursion_points_use_case.dart';
import 'package:krokapp_multiplatform/map/location_manager.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';

class ExcursionViewModel extends MapViewModel {
  GetExcursionPointsUseCase _excursionUseCase;
  BuildContext _context;

  ExcursionViewModel(
    this._excursionUseCase,
    this._context,
    LocationManager locationManager,
    BuildRouteUseCase buildRouteUseCase,
  ) : super(locationManager, buildRouteUseCase);

  @override
  void onLocationObtained() {
    if (currentLocation == null) {
      Navigator.of(_context).pop();
      onViewDispose();
      return;
    }

    setupExcursion(
      (currentLatLng) => _excursionUseCase.invoke(currentLatLng),
    );
  }

  void onSettingsIconClicked() {
    Navigator.pushNamed(_context, KrokAppRoutes.EXCURSION_SETTINGS);
  }
}
