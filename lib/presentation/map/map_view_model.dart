import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/map/location_manager.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

const MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);

abstract class MapViewModel {
  LocationManager _locationManager;
  @protected
  Location? currentLocation;

  List<MarkerInfo> markers = List.empty(growable: true);
  List<LatLng> route = List.empty(growable: true);
  LatLng startLocation = MINSK_RAILROAD_LOCATION;

  @protected
  final onViewUpdateController = BehaviorSubject.seeded(true);
  late Stream onViewUpdate;

  @protected
  final subscriptions = CompositeSubscription();

  MapViewModel(
    this._locationManager,
  ) {
    onViewUpdate = onViewUpdateController.stream;
  }

  void onViewInit() {
    _setupLocation();
  }

  void _setupLocation() async {
    currentLocation = await _locationManager.getCurrentLocation();
    onLocationObtained();
    updateView();
  }

  @protected
  void onLocationObtained() {}

  @protected
  void updateView() => onViewUpdateController.add(true);

  bool isShowCurrentLocation() => currentLocation != null;

  void onViewDispose() {
    subscriptions.dispose();
  }
}
