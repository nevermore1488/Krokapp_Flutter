import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';

abstract class CitiesDao extends CommonDao<CityTable> {
  Stream<List<CityTable>> getCityById(int cityId);
}

class CitiesDaoImpl extends LocalizedDao<CityTable> implements CitiesDao {
  CitiesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          CityTable.TABLE_NAME,
          CitiesJsonConverter(),
        );

  @override
  Stream<List<CityTable>> getCityById(int cityId) => query(
        "${getSelectQuery()} and ${CityTable.COLUMN_PLACE_ID} = $cityId",
        getEngagedTables(),
      );
}
