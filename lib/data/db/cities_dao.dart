import 'package:krokapp_multiplatform/data/db/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/city_table.dart';

abstract class CitiesDao extends LocalizedDao<CityTable> {}

class CitiesDaoImpl extends LocalizedDaoImpl<CityTable> implements CitiesDao {
  CitiesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          CITIES_TABLE_NAME,
          CitiesJsonConverter(),
          "lang",
        );
}
