import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:krokapp_multiplatform/data/json_converter.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';
import 'package:krokapp_multiplatform/data/tables/languages_table.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';
import 'package:krokapp_multiplatform/resources.dart';

const _KROK_API = "http://krokapp.by/api/";
const _BNR_API = "http://bnr.krokam.by/api/";

class CommonApi<T> {
  JsonConverter _jsonConverter;
  BuildType buildType;

  CommonApi(this._jsonConverter, {this.buildType = BuildType.krokapp});

  Future<List<T>> get(String path) async {
    String host = buildType == BuildType.krokapp ? _KROK_API : _BNR_API;
    final response = await http.get(Uri.parse(host + path));
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
  BuildType _buildType;

  CitiesApiImpl(this._buildType)
      : super(CitiesJsonConverter(isApi: true), buildType: _buildType);

  @override
  Future<List<CitiesTable>> getCities(int weirdParam) {
    String path =
        _buildType == BuildType.krokapp ? 'get_cities/' : 'get_sections/';
    return get('$path$weirdParam');
  }
}

abstract class PointsApi {
  Future<List<PointsTable>> getPoints(int weirdParam);
}

class PointsApiImpl extends CommonApi<PointsTable> implements PointsApi {
  BuildType _buildType;

  PointsApiImpl(this._buildType)
      : super(PointsJsonConverter(isApi: true), buildType: _buildType);

  @override
  Future<List<PointsTable>> getPoints(int weirdParam) {
    String path =
        _buildType == BuildType.krokapp ? 'get_points/' : 'get_exhibits/';
    return get('$path$weirdParam');
  }
}

abstract class LanguagesApi {
  Future<List<LanguagesTable>> getLanguages();
}

class LanguagesApiImpl extends CommonApi<LanguagesTable>
    implements LanguagesApi {
  LanguagesApiImpl(BuildType buildType)
      : super(LanguagesJsonConverter(), buildType: buildType  );

  @override
  Future<List<LanguagesTable>> getLanguages() => get('get_languages');
}

abstract class TagsApi {
  Future<List<TagsTable>> getTags();
}

class TagsApiImpl extends CommonApi<TagsTable> implements TagsApi {
  BuildType _buildType;

  TagsApiImpl(this._buildType)
      : super(TagsJsonConverter(), buildType: _buildType);

  @override
  Future<List<TagsTable>> getTags() => _buildType == BuildType.krokapp
      ? get('get_tags')
      : Future.value(List.empty());
}
