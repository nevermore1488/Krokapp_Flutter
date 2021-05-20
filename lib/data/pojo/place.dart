class Place {
  final int id;
  final String title;
  final String logo;
  final bool isShowFavorite;
  final bool isFavorite;

  Place(
    this.id,
    this.title,
    this.logo, [
    this.isShowFavorite = false,
    this.isFavorite = false,
  ]);
}

enum PlaceType { cities, points, detail, favorite, excursion }
