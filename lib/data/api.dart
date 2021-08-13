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

  Future<List<T>> get(String path) async {
    final response = await http.get(Uri.parse(_KROK_API + path));
    if (response.statusCode == 200) {
      return _jsonConverter.fromJsonList(jsonDecode(response.body)).cast();
    } else {
      throw HttpException(response.body, uri: response.request?.url);
    }
  }
}

abstract class CitiesApi {
  Future<List<CitiesTable>> getCities(int weirdParam);
}

class CitiesApiImpl extends CommonApi<CitiesTable> implements CitiesApi {
  CitiesApiImpl() : super(CitiesJsonConverter(isApi: true));

  @override
  Future<List<CitiesTable>> getCities(int weirdParam) {
    return get('get_cities/$weirdParam');
  }
}

abstract class PointsApi {
  Future<List<PointsTable>> getPoints(int weirdParam);
}

class PointsApiImpl extends CommonApi<PointsTable> implements PointsApi {
  PointsApiImpl() : super(PointsJsonConverter(isApi: true));

  @override
  Future<List<PointsTable>> getPoints(int weirdParam) {
    return get('get_points/$weirdParam');
  }
}

abstract class LanguagesApi {
  Future<List<LanguagesTable>> getLanguages();
}

class LanguagesApiImpl extends CommonApi<LanguagesTable>
    implements LanguagesApi {
  LanguagesApiImpl() : super(LanguagesJsonConverter());

  @override
  Future<List<LanguagesTable>> getLanguages() => get('get_languages');
}

abstract class TagsApi {
  Future<List<TagsTable>> getTags();
}

class TagsApiImpl extends CommonApi<TagsTable> implements TagsApi {
  TagsApiImpl() : super(TagsJsonConverter());

  @override
  Future<List<TagsTable>> getTags() => get('get_tags');
}
