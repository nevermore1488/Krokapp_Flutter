import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

class PlaceViewModel {
  SelectArgs selectArgs;
  PlaceUseCase _placeUseCase;
  BuildContext _context;

  PlaceViewModel(
    this.selectArgs,
    this._placeUseCase,
    this._context,
  );

  Stream<String> getTitle() {
    if (selectArgs.cityId != null) {
      return _placeUseCase
          .getPlacesBySelectArgs(SelectArgs(placeType: PlaceType.CITIES, id: selectArgs.cityId))
          .map((event) => event.first.title);
    } else if (selectArgs.id != null) {
      return _placeUseCase.getPlacesBySelectArgs(selectArgs).map((event) => event.first.title);
    } else if (selectArgs.placeType == PlaceType.CITIES) {
      return Future.value(AppLocalizations.of(_context)!.cities_title).asStream();
    } else if (selectArgs.isFavorite == true) {
      return Future.value(AppLocalizations.of(_context)!.nav_menu_item_bookmarks).asStream();
    } else if (selectArgs.isVisited == true) {
      return Future.value(AppLocalizations.of(_context)!.nav_menu_item_visited).asStream();
    } else
      throw Exception("no such place mode");
  }
}
