import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/presentation/place/list/place_list_use_case.dart';
import 'package:krokapp_multiplatform/presentation/place/place_page.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';

class PlaceListViewModel {
  PlaceMode _placeMode;
  PlaceListUseCase _placeListUseCase;
  BuildContext _context;

  late Stream<List<Place>> places;

  PlaceListViewModel(
    this._placeMode,
    this._placeListUseCase,
    this._context,
  ) {
    places = _placeListUseCase.getPlaces(_placeMode);
  }

  void onPlaceClick(Place place) {
    switch (_placeMode.runtimeType) {
      case CitiesMode:
        {
          _push(PointsMode(cityId: place.id));
          break;
        }
      case PointsMode:
        {
          _push(DetailMode(pointId: place.id));
          break;
        }
    }
  }

  void onPlaceFavoriteClick(Place place) {}

  void _push(PlaceMode placeMode) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => PlacePage(placeMode: placeMode)),
    );
  }
}
