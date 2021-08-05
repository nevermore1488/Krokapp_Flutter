import 'package:krokapp_multiplatform/business/location_manager.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';

class PlaceMapViewModel extends MapViewModel {
  SelectArgs _selectArgs;
  PlaceUseCase _placeUseCase;

  PlaceMapViewModel(
    this._selectArgs,
    this._placeUseCase,
    LocationManager locationManager,
  ) : super(locationManager);

  @override
  void onViewInit() {
    super.onViewInit();

    final markersSubscription = _createMarkers().listen((event) {
      this.markers.clear();
      this.markers.addAll(event);
      updateView();
    });

    subscriptions.add(markersSubscription);
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
