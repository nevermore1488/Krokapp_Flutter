import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';

abstract class CitiesDao extends CommonDao<CitiesTable> {
  Stream<List<CitiesTable>> getCitiesBySelectArgs(SelectArgs selectArgs);
}

class CitiesDaoImpl extends LocalizedDao<CitiesTable> implements CitiesDao {
  CitiesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          CitiesTable.TABLE_NAME,
          CitiesJsonConverter(),
        );

  @override
  Stream<List<CitiesTable>> getCitiesBySelectArgs(
    SelectArgs selectionArgs,
  ) {
    late String selectionWhere;
    if (selectionArgs.id != null) {
      selectionWhere = "${CitiesTable.COLUMN_PLACE_ID} = ${selectionArgs.id}";
    } else
      return getAll();

    return query(
      "${getSelectQuery()} and $selectionWhere",
      getEngagedTables(),
    );
  }
}
