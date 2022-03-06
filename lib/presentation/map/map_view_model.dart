import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/data/pojo/lat_lng.dart';
import 'package:krokapp_multiplatform/business/usecases/build_route_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/map/location_manager.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

final MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);

abstract class MapViewModel {
  LocationManager _locationManager;
  BuildRouteUseCase _buildRouteUseCase;
  Location? currentLocation;

  List<MarkerInfo> markers = List.empty(growable: true);
  List<LatLng> route = List.empty(growable: true);
  LatLng startLocation = MINSK_RAILROAD_LOCATION;

  @protected
  final onViewUpdateController = BehaviorSubject.seeded(true);
  late Stream onViewUpdate;

  @protected
  StreamSubscription? markersSubscription;

  @protected
  StreamSubscription? routeSubscription;

  bool _isNeedMoveToCurrentLocation = false;

  bool get isNeedMoveToCurrentLocation => _isNeedMoveToCurrentLocation;

  MapViewModel(
    this._locationManager,
    this._buildRouteUseCase,
  ) {
    onViewUpdate = onViewUpdateController.stream;
  }

  void onViewInit() {
    _setupLocation();
  }

  @protected
  setupExcursion(
      Stream<List<MarkerInfo>> excursionPoints(LatLng currentLocation)) async {
    var currentLocationData = await currentLocation!.getLocation();
    var currentLatLng = LatLng(
      currentLocationData.latitude!,
      currentLocationData.longitude!,
    );

    setupMarkers(
      excursionPoints(currentLatLng),
    );

    setupRoute(
      excursionPoints(currentLatLng).asyncMap((event) => _buildRouteUseCase
          .invoke([currentLatLng] + event.map((e) => e.latLng).toList())),
    );
  }

  @protected
  void setupMarkers(Stream<List<MarkerInfo>> markersStream) {
    markersSubscription?.cancel();

    markersSubscription = markersStream.listen((event) {
      markers.clear();
      markers.addAll(event);
      updateView();
    });
  }

  @protected
  void setupRoute(Stream<List<LatLng>> routeStream) {
    routeSubscription?.cancel();

    routeSubscription = routeStream.listen((event) {
      route.clear();
      route.addAll(event);
      updateView();
    });
  }

  void _setupLocation() async {
    await _obtainLocation();
    onLocationObtained();
    updateView();
  }

  Future _obtainLocation() async {
    Location? newCurrentLocation = await _locationManager.getCurrentLocation();
    _isNeedMoveToCurrentLocation =
        newCurrentLocation != null && currentLocation == null;
    currentLocation = newCurrentLocation;
  }

  void onMovedToCurrentLocation() {
    _isNeedMoveToCurrentLocation = false;
  }

  @protected
  void onLocationObtained() {}

  @protected
  void updateView() => onViewUpdateController.add(true);

  bool isShowCurrentLocation() => currentLocation != null;

  void onViewDispose() {
    markersSubscription?.cancel();
    routeSubscription?.cancel();
  }
}
