class MarkerInfo {
  final String id;
  final String title;
  final double lat;
  final double lng;

  MarkerInfo(
    this.id,
    this.title,
    this.lat,
    this.lng,
  );
}

enum PlaceType { cities, points, detail, favorite, excursion }
