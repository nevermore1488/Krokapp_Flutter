import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_model.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_use_case.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/place_use_case.dart';

abstract class PlaceListViewModel {
  Stream<List<Place>> getPlaces();

  void onPlaceClick(Place place);

  void onPlaceFavoriteClick(Place place);
}

abstract class MapViewModel {
  Stream<MapModel> getMapModel();

  void onMarkerHintClick(MarkerInfo marker);
}

abstract class DetailViewModel {
  Stream<PlaceDetail> getPlaceDetail(int placeId);
}

class PlaceViewModel implements PlaceListViewModel, MapViewModel, DetailViewModel {
  PlaceMode _placeMode;
  PlaceUseCase _placeUseCase;
  MapUseCase _mapUseCase;
  BuildContext _context;

  late Stream<List<Place>> _places;
  late Stream<MapModel> _mapModel;

  PlaceViewModel(
    this._placeMode,
    this._placeUseCase,
    this._mapUseCase,
    this._context,
  ) {
    _places = _placeUseCase.getPlaces(_placeMode);
    _mapModel = _mapUseCase.getMapModel(_placeMode);
  }

  // list

  @override
  Stream<List<Place>> getPlaces() => _places;

  @override
  void onPlaceClick(Place place) {
    _pushByPlaceId(place.id);
  }

  @override
  void onPlaceFavoriteClick(Place place) {}

  // map

  @override
  Stream<MapModel> getMapModel() => _mapModel;

  @override
  void onMarkerHintClick(MarkerInfo marker) => _pushByPlaceId(int.parse(marker.id));

  // detail

  @override
  Stream<PlaceDetail> getPlaceDetail(int placeId) => _placeUseCase.getPlaceDetail(placeId);

  // impl

  void _pushByPlaceId(int placeId) {
    switch (_placeMode.runtimeType) {
      case CitiesMode:
        {
          _push(PointsMode(cityId: placeId));
          break;
        }
      case PointsMode:
        {
          _push(DetailMode(pointId: placeId));
          break;
        }
    }
  }

  void _push(PlaceMode placeMode) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => PlacePage(placeMode: placeMode)),
    );
  }
}
