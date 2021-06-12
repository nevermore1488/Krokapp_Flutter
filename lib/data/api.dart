import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';
import 'package:krokapp_multiplatform/data/tables/languages_table.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';

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
  Stream<List<CitiesTable>> getCities(int weirdParam);
}

class CitiesApiImpl extends CommonApi<CitiesTable> implements CitiesApi {
  CitiesApiImpl() : super(CitiesJsonConverter(isApi: true));

  @override
  Stream<List<CitiesTable>> getCities(int weirdParam) => get('get_cities/$weirdParam');
}

abstract class PointsApi {
  Stream<List<PointsTable>> getPoints(int weirdParam);
}

class PointsApiImpl extends CommonApi<PointsTable> implements PointsApi {
  PointsApiImpl() : super(PointsJsonConverter(isApi: true));

  @override
  Stream<List<PointsTable>> getPoints(int weirdParam) => get('get_points/$weirdParam');
}

abstract class LanguagesApi {
  Stream<List<LanguagesTable>> getLanguages();
}

class LanguagesApiImpl extends CommonApi<LanguagesTable> implements LanguagesApi {
  LanguagesApiImpl() : super(LanguagesJsonConverter());

  @override
  Stream<List<LanguagesTable>> getLanguages() => get('get_languages');
}

abstract class TagsApi {
  Stream<List<TagsTable>> getTags();
}

class TagsApiImpl extends CommonApi<TagsTable> implements TagsApi {
  TagsApiImpl() : super(TagsJsonConverter());

  @override
  Stream<List<TagsTable>> getTags() => get('get_tags');
}
