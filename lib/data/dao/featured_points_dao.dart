import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';
import 'package:krokapp_multiplatform/data/tables/cities_table.dart';
import 'package:krokapp_multiplatform/data/tables/featured_point_table.dart';
import 'package:krokapp_multiplatform/data/tables/place_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/points_table.dart';

abstract class FeaturedPointsDao extends CommonDao<FeaturedPointTable> {
  Stream<List<FeaturedPointTable>> getPointsBySelectArgs(SelectArgs selectArgs);
}

class FeaturedPointsDaoImpl extends LocalizedDao<FeaturedPointTable>
    implements FeaturedPointsDao {
  FeaturedPointsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PointsTable.TABLE_NAME,
          FeaturedPointsJsonConverter(),
        );

  @override
  List<String> getEngagedTables() =>
      super.getEngagedTables() + [PlaceFeaturesTable.TABLE_NAME];

  @override
  String beforeWhereStatement() => "LEFT JOIN ${PlaceFeaturesTable.TABLE_NAME}"
      " ON ${PointsTable.TABLE_NAME}.${PointsTable.COLUMN_PLACE_ID}"
      " = ${PlaceFeaturesTable.TABLE_NAME}.${PlaceFeaturesTable.FEATURED_COLUMN_PLACE_ID}";

  @override
  Stream<List<FeaturedPointTable>> getPointsBySelectArgs(
      SelectArgs selectArgs) {
    late String selectionWhere;
    if (selectArgs.id != null) {
      selectionWhere = "${PointsTable.COLUMN_PLACE_ID} = ${selectArgs.id}";
    } else if (selectArgs.cityId != null) {
      selectionWhere = "${PointsTable.COLUMN_CITY_ID} = ${selectArgs.cityId}";
    } else if (selectArgs.isFavorite) {
      selectionWhere = "${PlaceFeaturesTable.COLUMN_IS_FAVORITE} = 1";
    } else if (selectArgs.isVisited) {
      selectionWhere = "${PlaceFeaturesTable.COLUMN_IS_VISITED} = 1";
    } else
      return getAll();

    List<String> queryTables =
        selectArgs.cityId != null ? [CitiesTable.TABLE_NAME] : [];
    return query(
      "${getSelectQuery()} and $selectionWhere",
      getEngagedTables() + queryTables,
    );
  }
}
