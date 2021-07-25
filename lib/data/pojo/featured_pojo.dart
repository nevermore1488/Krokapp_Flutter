import 'package:krokapp_multiplatform/data/json_converter.dart';

class FeaturedPojo<P, F> {
  JsonConverter<P> _pojoJsonConverter;
  JsonConverter<F> _featureJsonConverter;
  late P pojoTable;
  late F featureTable;

  FeaturedPojo.fromJson(
    this._pojoJsonConverter,
    this._featureJsonConverter,
    dynamic json,
  ) {
    pojoTable = _pojoJsonConverter.fromJson(json);
    featureTable = _featureJsonConverter.fromJson(json);
  }
}
