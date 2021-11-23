import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';
import 'package:krokapp_multiplatform/data/tables/languages_table.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';

class CommonApi<T> {
  JsonConverter _jsonConverter;
  String baseUrl;

  CommonApi(this._jsonConverter, this.baseUrl);

  Future<List<T>> get(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));
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
  String path;

  CitiesApiImpl(String baseUrl, this.path)
      : super(CitiesJsonConverter(isApi: true), baseUrl);

  @override
  Future<List<CitiesTable>> getCities(int weirdParam) =>
      get('$path$weirdParam');
}

abstract class PointsApi {
  Future<List<PointsTable>> getPoints(int weirdParam);
}

class PointsApiImpl extends CommonApi<PointsTable> implements PointsApi {
  String path;

  PointsApiImpl(String baseUrl, this.path)
      : super(PointsJsonConverter(isApi: true), baseUrl);

  @override
  Future<List<PointsTable>> getPoints(int weirdParam) =>
      get('$path$weirdParam');
}

abstract class LanguagesApi {
  Future<List<LanguagesTable>> getLanguages();
}

class LanguagesApiImpl extends CommonApi<LanguagesTable>
    implements LanguagesApi {
  LanguagesApiImpl(String baseUrl) : super(LanguagesJsonConverter(), baseUrl);

  @override
  Future<List<LanguagesTable>> getLanguages() => get('get_languages');
}

abstract class TagsApi {
  Future<List<TagsTable>> getTags();
}

class TagsApiImpl extends CommonApi<TagsTable> implements TagsApi {
  bool isLoadTags;

  TagsApiImpl(String baseUrl, this.isLoadTags)
      : super(TagsJsonConverter(), baseUrl);

  @override
  Future<List<TagsTable>> getTags() =>
      isLoadTags ? get('get_tags') : Future.value(List.empty());
}
