import 'package:krokapp_multiplatform/data/db/common_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';
import 'package:sqflite/sqflite.dart';

abstract class CitiesDao extends CommonDao<CityTable> {}

class CitiesDaoImpl extends CommonDaoImpl<CityTable> implements CitiesDao {
  CitiesDaoImpl(Future<Database> dbFuture) : super(dbFuture, CITIES_TABLE_NAME);

  @override
  List<Map<String, Object?>> entitiesToJson(List<CityTable> entities) =>
      entities.map((e) => e.toJson()).toList();

  @override
  List<CityTable> jsonToEntities(List<Map<String, Object?>> json) =>
      json.map((e) => CityTable.fromJson(e)).toList();
}
