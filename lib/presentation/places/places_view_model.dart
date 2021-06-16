import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/business/player_model.dart';
import 'package:krokapp_multiplatform/business/usecases/place_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/place.dart';
import 'package:krokapp_multiplatform/data/pojo/place_detail.dart';
import 'package:krokapp_multiplatform/data/pojo/place_feature.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/presentation/places/places_with_map_page.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class PlacesViewModel {
  SelectArgs selectArgs;
  PlaceUseCase _placeUseCase;
  BuildContext _context;

  var _isShowPlacesController = BehaviorSubject<bool>.seeded(true);
  var _isShowMapController = BehaviorSubject<bool>.seeded(false);

  PlayerModel? _playerModel;

  PlacesViewModel(
    this.selectArgs,
    this._placeUseCase,
    this._context,
  );

  Stream<bool> getIsShowPlaces() => _isShowPlacesController.stream;

  Stream<bool> getIsShowMap() => _isShowMapController.stream;

  void onSwitchIconClicked() {
    _isShowPlacesController.value = !_isShowPlacesController.value;
    //for late init of map
    if (!_isShowMapController.value) {
      _isShowMapController.value = true;
    }
  }

  Stream<String> getTitle() {
    if (selectArgs.cityId != null) {
      return _placeUseCase
          .getPlacesBySelectArgs(SelectArgs(placeType: PlaceType.city, id: selectArgs.cityId))
          .map((event) => event.first.title);
    } else if (selectArgs.id != null) {
      return _placeUseCase.getPlacesBySelectArgs(selectArgs).map((event) => event.first.title);
    } else if (selectArgs.placeType == PlaceType.city) {
      return Future.value(AppLocalizations.of(_context)!.cities_title).asStream();
    } else if (selectArgs.isFavorite == true) {
      return Future.value(AppLocalizations.of(_context)!.nav_menu_item_bookmarks).asStream();
    } else if (selectArgs.isVisited == true) {
      return Future.value(AppLocalizations.of(_context)!.nav_menu_item_visited).asStream();
    } else
      throw Exception("no such place mode");
  }

  Stream<List<Place>> getPlaces() => _placeUseCase.getPlacesBySelectArgs(selectArgs);

  Stream<PlaceDetail> getPlaceDetail() =>
      getPlaces().map((event) => event.first as PlaceDetail).first.asStream();

  void onPlaceClick(Place place) {
    _pushByPlaceId(place.id);
  }

  void onPlaceFavoriteClick(Place place) {
    _placeUseCase.savePointFeature(PlaceFeature(
      placeId: place.id,
      isFavorite: !place.isFavorite,
      isVisited: place.isVisited,
    ));
  }

  void onPlaceVisitedClick(Place place) {
    _placeUseCase.savePointFeature(PlaceFeature(
      placeId: place.id,
      isFavorite: place.isFavorite,
      isVisited: !place.isVisited,
    ));
  }

  void _pushByPlaceId(int placeId) {
    final selectArgs = SelectArgs(placeType: PlaceType.point);

    if (this.selectArgs.placeType == PlaceType.city)
      selectArgs.cityId = placeId;
    else
      selectArgs.id = placeId;

    _push(selectArgs);
  }

  void _push(SelectArgs selectArgs) {
    Navigator.push(
      _context,
      MaterialPageRoute(
          builder: (context) => createPlacesWithMapPageInProvider(
                selectArgs,
                Provider.of(context),
              )),
    );
  }

  PlayerModel getPlayerModel(PlaceDetail place) {
    _playerModel = PlayerModel(place.sound);
    return _playerModel!;
  }
}
