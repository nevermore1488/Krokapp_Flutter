import 'package:krokapp_multiplatform/data/pojo/place.dart';

class SelectArgs {
  PlaceType placeType;
  int? id;
  int? cityId;
  bool isFavorite;
  bool isVisited;
  bool isExcursion;

  SelectArgs({
    required this.placeType,
    this.id,
    this.cityId,
    this.isFavorite = false,
    this.isVisited = false,
    this.isExcursion = false,
  });
}
