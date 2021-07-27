import 'package:flutter/cupertino.dart';
import 'package:krokapp_multiplatform/business/location_manager.dart';
import 'package:krokapp_multiplatform/business/usecases/excursion_use_case.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';

class ExcursionViewModel extends MapViewModel {
  ExcursionUseCase _excursionUseCase;
  BuildContext _context;

  ExcursionViewModel(
    this._excursionUseCase,
    this._context,
    LocationManager locationManager,
  ) : super(locationManager);

  @override
  void onLocationObtained() {
    if (currentLocation == null) {
      Navigator.of(_context).pop();
      onViewDispose();
      return;
    }
  }
}
