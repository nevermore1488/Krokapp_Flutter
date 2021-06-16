import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/business/usecases/map_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/map/map_model.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

const _MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);

class MapViewModel {
  SelectArgs _selectArgs;
  PlaceUseCase _placeUseCase;
  MapUseCase _mapUseCase;

  final _currentLocation = BehaviorSubject<Location?>.seeded(null);

  MapViewModel(
    this._selectArgs,
    this._placeUseCase,
    this._mapUseCase,
  ) {
    _initLocation();
  }

  void _initLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _currentLocation.add(location);
  }

  Stream<MapModel> getMapModel() =>
      _getMapModel(_selectArgs).switchMap((value) => _currentLocation.asyncMap((event) async {
            if (event == null) {
              value.startLocation = _MINSK_RAILROAD_LOCATION;
            } else {
              final location = await event.getLocation();
              final latLngLocation = LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0);
              value.currentLocation = latLngLocation;
              value.startLocation = latLngLocation;
            }
            return value;
          }));

  Stream<MapModel> _getMapModel(SelectArgs _selectArgs) => _placeUseCase
      .getPlacesBySelectArgs(
        _selectArgs.placeType == PlaceType.city
            ? SelectArgs(placeType: PlaceType.point)
            : _selectArgs,
      )
      .map(
        (event) => MapModel(
          markers: event.map((e) => e.toMarker()).toList(),
          route: List.empty(),
        ),
      );
}
