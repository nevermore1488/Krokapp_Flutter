class SelectArgs {
  PlaceType placeType;
  int? id;
  int? cityId;
  bool isFavorite;
  bool isVisited;

  SelectArgs({
    required this.placeType,
    this.id,
    this.cityId,
    this.isFavorite = false,
    this.isVisited = false,
  });
}

enum PlaceType { CITIES, POINTS }
