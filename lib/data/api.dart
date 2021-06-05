import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/language_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/point_table.dart';

const _KROK_API = "http://krokapp.by/api/";

class CommonApi<T> {
  JsonConverter _jsonConverter;
  String host;

  CommonApi(this._jsonConverter, {this.host = _KROK_API});

  Stream<List<T>> get(String path) => http.get(Uri.parse(_KROK_API + path)).asStream().map((resp) {
        if (resp.statusCode == 200) {
          return jsonDecode(resp.body);
        } else {
          throw HttpException(resp.body, uri: resp.request?.url);
        }
      }).map((event) => _jsonConverter.fromJsonList(event).cast());
}

abstract class CitiesApi {
  Stream<List<CityTable>> getCities(int weirdParam);
}

class CitiesApiImpl extends CommonApi<CityTable> implements CitiesApi {
  CitiesApiImpl() : super(CitiesJsonConverter(isApi: true));

  @override
  Stream<List<CityTable>> getCities(int weirdParam) => get('get_cities/$weirdParam');
}

abstract class PointsApi {
  Stream<List<PointTable>> getPoints(int weirdParam);
}

class PointsApiImpl extends CommonApi<PointTable> implements PointsApi {
  PointsApiImpl() : super(PointsJsonConverter(isApi: true));

  @override
  Stream<List<PointTable>> getPoints(int weirdParam) => get('get_points/$weirdParam');
}

abstract class LanguagesApi {
  Stream<List<LanguageTable>> getLanguages();
}

class LanguagesApiImpl extends CommonApi<LanguageTable> implements LanguagesApi {
  LanguagesApiImpl() : super(LanguagesJsonConverter());

  @override
  Stream<List<LanguageTable>> getLanguages() => get('get_languages');
}
