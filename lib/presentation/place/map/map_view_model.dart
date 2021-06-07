import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:krokapp_multiplatform/business/usecases/map_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_model.dart';

const _MINSK_RAILROAD_LOCATION = LatLng(53.891178, 27.551021);

class MapViewModel {
  SelectArgs _selectArgs;
  PlaceUseCase _placeUseCase;
  MapUseCase _mapUseCase;

  MapViewModel(
    this._selectArgs,
    this._placeUseCase,
    this._mapUseCase,
  );

  Stream<MapModel> getMapModel() => _getMapModel(_selectArgs);

  Stream<MapModel> _getMapModel(SelectArgs _selectArgs) => _placeUseCase
      .getPlacesBySelectArgs(
        _selectArgs.placeType == PlaceType.CITIES
            ? SelectArgs(placeType: PlaceType.POINTS)
            : _selectArgs,
      )
      .map(
        (event) => MapModel(
          markers: event.map((e) => e.toMarker()).toList(),
          route: List.empty(),
          startLocation:
              event.isNotEmpty ? event.first.toMarker().latLng : _MINSK_RAILROAD_LOCATION,
        ),
      );
}
