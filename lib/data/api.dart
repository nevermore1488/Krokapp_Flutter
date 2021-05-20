import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';

const _KROK_API = "http://krokapp.by/api/";

abstract class CitiesApi {
  Future<List<CityTable>> getCities();
}

class CitiesApiImpl implements CitiesApi {
  @override
  Future<List<CityTable>> getCities() async =>
      (await _getRequest('get_cities/1')).map((e) => CityTable.fromJson(e, isApi: true)).toList();
}

Future<List<dynamic>> _getRequest(String path) async {
  final response = await http.get(Uri.parse(_KROK_API + path));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw HttpException(response.body, uri: response.request?.url);
  }
}
