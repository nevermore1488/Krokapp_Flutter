import 'package:krokapp_multiplatform/data/pojo/lat_lng.dart';

class GoogleMapRepository {
  String _googleMapApiKey;

  GoogleMapRepository(
    this._googleMapApiKey,
  );

  Future<List<LatLng>> buildRouteBetweenPoints(List<LatLng> points) async {
    return List.empty();
  }
}
