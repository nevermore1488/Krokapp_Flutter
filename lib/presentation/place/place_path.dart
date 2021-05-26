abstract class PlaceMode {}

class CitiesMode implements PlaceMode {}

class PointsMode implements PlaceMode {
  int? cityId;
  bool? isExcursion;
  bool? isFavorite;
  bool? isVisited;
  bool? isDownloaded;

  PointsMode({
    this.cityId,
    this.isExcursion,
    this.isFavorite,
    this.isVisited,
    this.isDownloaded,
  });
}

class DetailMode implements PlaceMode {
  int pointId;

  DetailMode({
    required this.pointId,
  });
}
