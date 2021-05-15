import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:krokapp_multiplatform/data/place.dart';

class PlaceListModel extends ChangeNotifier {
  List<Place> places = _createPlaces();
  var isLoading = false;

  void onPlaceClick(BuildContext context, Place place) {}

  void onPlaceFavoriteClick(BuildContext context, Place place) {}

  static List<Place> _createPlaces() => List.generate(
        20,
        (index) => Place(
          index,
          "The Place " + (index + 1).toString(),
          "https://krokapp.by/media/place_logo/54b818aa-f116-4610-ae4a-e625c56c426f.png",
          true,
          false,
        ),
      );
}
