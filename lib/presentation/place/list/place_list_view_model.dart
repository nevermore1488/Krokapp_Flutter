import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/place/places_page.dart';
import 'package:provider/provider.dart';

class PlaceListViewModel {
  SelectArgs selectArgs;
  PlaceUseCase _placeUseCase;
  BuildContext _context;

  PlaceListViewModel(
    this.selectArgs,
    this._placeUseCase,
    this._context,
  );

  Stream<List<Place>> getPlaces() => _placeUseCase.getPlacesBySelectArgs(selectArgs);

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
    final selectArgs = SelectArgs(placeType: PlaceType.POINTS);

    if (this.selectArgs.placeType == PlaceType.CITIES)
      selectArgs.cityId = placeId;
    else
      selectArgs.id = placeId;

    _push(selectArgs);
  }

  void _push(SelectArgs selectArgs) {
    Navigator.push(
      _context,
      MaterialPageRoute(
          builder: (context) => createPlacesPageWithProvider(
                selectArgs,
                Provider.of(context),
              )),
    );
  }
}
