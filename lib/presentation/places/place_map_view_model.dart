import 'package:krokapp_multiplatform/business/usecases/build_route_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/map/location_manager.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:krokapp_multiplatform/resources.dart';

class PlaceMapViewModel extends MapViewModel {
  SelectArgs _selectArgs;
  PlaceUseCase _placeUseCase;
  BuildType _buildType;

  PlaceMapViewModel(
    this._selectArgs,
    this._placeUseCase,
    this._buildType,
    LocationManager locationManager,
    BuildRouteUseCase buildRouteUseCase,
  ) : super(locationManager, buildRouteUseCase);

  @override
  void onViewInit() {
    super.onViewInit();

    setupMarkers(_createMarkers());
  }

  @override
  void onLocationObtained() {
    if (currentLocation != null &&
        _selectArgs.placeType == PlaceType.point &&
        _buildType == BuildType.bnr) {

      setupExcursion((currentLocation) => _createMarkers());
    }
  }

  Stream<List<MarkerInfo>> _createMarkers() {
    return _placeUseCase.getPlacesBySelectArgs(_createMapSelectArgs()).map(
          (event) => event.map((e) => e.toMarker()).toList(),
        );
  }

  SelectArgs _createMapSelectArgs() {
    return _selectArgs.placeType == PlaceType.city
        ? SelectArgs(placeType: PlaceType.point)
        : _selectArgs;
  }
}
