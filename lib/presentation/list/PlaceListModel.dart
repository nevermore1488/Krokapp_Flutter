import 'package:flutter/foundation.dart';
import 'package:krokapp_multiplatform/data/Place.dart';

class PlaceListModel extends ChangeNotifier {
  List<Place> places;
  bool isLoading;

  PlaceListModel() {
    places = _createPlaces();
  }

  void onPlaceClick(Place place) {}

  void onPlaceFavoriteClick(Place place) {}

  List<Place> _createPlaces() => List.generate(
        20,
        (index) => Place(
          index,
          "The Place",
          "https://krokapp.by/media/place_logo/54b818aa-f116-4610-ae4a-e625c56c426f.png",
          true,
          false,
        ),
      );
}
