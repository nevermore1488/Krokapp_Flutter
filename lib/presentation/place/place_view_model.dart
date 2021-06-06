import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/business/usecases/map_use_case.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/marker_info.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/presentation/place/map/map_model.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/places_page.dart';

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

  PlaceViewModel(
    this._placeMode,
    this._placeUseCase,
    this._mapUseCase,
    this._context,
  );

  Stream<List<Place>> _getPlacesByMode(PlaceMode placeMode) {
    switch (placeMode.runtimeType) {
      case CitiesMode:
        return _placeUseCase.getCities();

      case PointsMode:
        return _placeUseCase.getPointsOfCity((placeMode as PointsMode).cityId!);

      case DetailMode:
        return Future<List<Place>>(() => List.empty()).asStream();

      default:
        throw Exception("no such place mode");
    }
  }

  Stream<String> getTitle() {
    switch (_placeMode.runtimeType) {
      case CitiesMode:
        return Future.value(AppLocalizations.of(_context)!.cities_title).asStream();

      case PointsMode:
        return _placeUseCase
            .getCityById((_placeMode as PointsMode).cityId!)
            .map((event) => event.first.title);

      case DetailMode:
        return _placeUseCase
            .getPointById((_placeMode as DetailMode).pointId)
            .map((event) => event.first.title);

      default:
        throw Exception("no such place mode");
    }
  }

  // list

  @override
  Stream<List<Place>> getPlaces() =>
      _getPlacesByMode(_placeMode).where((event) => event.isNotEmpty);

  @override
  void onPlaceClick(Place place) {
    _pushByPlaceId(place.id);
  }

  @override
  void onPlaceFavoriteClick(Place place) {
    _placeUseCase.savePlaceFeature(PlaceFeature(
      placeId: place.id,
      isFavorite: !place.isFavorite,
      isVisited: place.isVisited,
    ));
  }

  // map

  @override
  Stream<MapModel> getMapModel() => _mapUseCase.getMapModel(_placeMode);

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
      MaterialPageRoute(builder: (context) => PlacesPage(placeMode: placeMode)),
    );
  }
}
