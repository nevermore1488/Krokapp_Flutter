import 'package:krokapp_multiplatform/data/db/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';

abstract class CitiesDao extends LocalizedDao<CityTable> {
  Stream<List<CityTable>> getCityById(int cityId);
}

class CitiesDaoImpl extends LocalizedDaoImpl<CityTable> implements CitiesDao {
  CitiesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          CityTable.TABLE_NAME,
          CitiesJsonConverter(),
          "lang",
        );

  @override
  Stream<List<CityTable>> getCityById(int cityId) => query(
    "${getLocalizedSelectQuery()} and ${CityTable.COLUMN_PLACE_ID} = $cityId",
    getLocalizedEngagedTables(),
  );
}
