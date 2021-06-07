import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

abstract class CitiesDao extends CommonDao<CityTable> {
  Stream<List<CityTable>> getCitiesBySelectArgs(SelectArgs selectArgs);
}

class CitiesDaoImpl extends LocalizedDao<CityTable> implements CitiesDao {
  CitiesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          CityTable.TABLE_NAME,
          CitiesJsonConverter(),
        );

  @override
  Stream<List<CityTable>> getCitiesBySelectArgs(
    SelectArgs selectionArgs,
  ) {
    late String selectionWhere;
    if (selectionArgs.id != null) {
      selectionWhere = "${CityTable.COLUMN_PLACE_ID} = ${selectionArgs.id}";
    } else
      return getAll();

    return query(
      "${getSelectQuery()} and $selectionWhere",
      getEngagedTables(),
    );
  }
}
