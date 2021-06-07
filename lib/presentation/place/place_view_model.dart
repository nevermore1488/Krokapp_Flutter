import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/presentation/place/place_path.dart';

class PlaceViewModel {
  PlaceMode placeMode;
  PlaceUseCase _placeUseCase;
  BuildContext _context;

  PlaceViewModel(
    this.placeMode,
    this._placeUseCase,
    this._context,
  );

  Stream<PlaceDetail> getPlaceDetail(int placeId) => _placeUseCase.getPlaceDetail(placeId);

  Stream<String> getTitle() {
    switch (placeMode.runtimeType) {
      case CitiesMode:
        return Future.value(AppLocalizations.of(_context)!.cities_title).asStream();

      case PointsMode:
        var mode = (placeMode as PointsMode);
        if (mode.cityId != null) {
          return _placeUseCase.getPointsOfCity(mode.cityId!).map((event) => event.first.title);
        } else if (mode.isFavorite == true) {
          return Future.value(AppLocalizations.of(_context)!.nav_menu_item_bookmarks).asStream();
        } else if (mode.isVisited == true) {
          return Future.value(AppLocalizations.of(_context)!.nav_menu_item_visited).asStream();
        } else
          throw Exception("no such place mode");

      case DetailMode:
        return _placeUseCase
            .getPointById((placeMode as DetailMode).pointId)
            .map((event) => event.first.title);

      default:
        throw Exception("no such place mode");
    }
  }
}
