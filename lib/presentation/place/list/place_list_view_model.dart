import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';
import 'package:krokapp_multiplatform/presentation/place/places_page.dart';
import 'package:provider/provider.dart';

class PlaceListViewModel {
  PlaceMode _placeMode;
  PlaceUseCase _placeUseCase;
  BuildContext _context;

  PlaceListViewModel(
    this._placeMode,
    this._placeUseCase,
    this._context,
  );

  Stream<List<Place>> _getPlacesByMode(PlaceMode placeMode) {
    switch (placeMode.runtimeType) {
      case CitiesMode:
        return _placeUseCase.getCities();

      case PointsMode:
        {
          var mode = (placeMode as PointsMode);
          if (mode.cityId != null) {
            return _placeUseCase.getPointsOfCity(mode.cityId!);
          } else if (mode.isFavorite == true) {
            return _placeUseCase.getFavorites();
          } else if (mode.isVisited == true) {
            return _placeUseCase.getVisited();
          } else
            throw Exception("no such place mode");
        }
      case DetailMode:
        return Future<List<Place>>(() => List.empty()).asStream();

      default:
        throw Exception("no such place mode");
    }
  }

  // list

  Stream<List<Place>> getPlaces() =>
      _getPlacesByMode(_placeMode).where((event) => event.isNotEmpty);

  void onPlaceClick(Place place) {
    _pushByPlaceId(place.id);
  }

  void onPlaceFavoriteClick(Place place) {
    _placeUseCase.savePlaceFeature(PlaceFeature(
      placeId: place.id,
      isFavorite: !place.isFavorite,
      isVisited: place.isVisited,
    ));
  }

  void onPlaceVisitedClick(Place place) {
    _placeUseCase.savePlaceFeature(PlaceFeature(
      placeId: place.id,
      isFavorite: place.isFavorite,
      isVisited: !place.isVisited,
    ));
  }

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
      MaterialPageRoute(
          builder: (context) => createPlacesPageWithProvider(
                placeMode,
                Provider.of(context),
              )),
    );
  }
}
