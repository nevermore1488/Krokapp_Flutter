import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/feature_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/featured_point_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/point_table.dart';
import 'package:krokapp_multiplatform/data/select_args.dart';

abstract class FeaturedPointsDao extends CommonDao<FeaturedPointTable> {
  Stream<List<FeaturedPointTable>> getPointsBySelectArgs(SelectArgs selectArgs);
}

class FeaturedPointsDaoImpl extends LocalizedDao<FeaturedPointTable> implements FeaturedPointsDao {
  FeaturedPointsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PointTable.TABLE_NAME,
          FeaturedPointsJsonConverter(),
        );

  @override
  Future<void> add(List<FeaturedPointTable> entities) {
    throw Exception("Use combination of PointsDao and FeatureDao instead.");
  }

  @override
  List<String> getEngagedTables() => super.getEngagedTables() + [FeatureTable.TABLE_NAME];

  @override
  String beforeWhereStatement() => "LEFT JOIN ${FeatureTable.TABLE_NAME}"
      " ON ${PointTable.TABLE_NAME}.${PointTable.COLUMN_PLACE_ID}"
      " = ${FeatureTable.TABLE_NAME}.${FeatureTable.COLUMN_PLACE_ID}";

  @override
  Stream<List<FeaturedPointTable>> getPointsBySelectArgs(SelectArgs selectArgs) {
    late String selectionWhere;
    if (selectArgs.id != null) {
      selectionWhere = "${PointTable.COLUMN_PLACE_ID} = ${selectArgs.id}";
    } else if (selectArgs.cityId != null) {
      selectionWhere = "${PointTable.COLUMN_CITY_ID} = ${selectArgs.cityId}";
    } else if (selectArgs.isFavorite) {
      selectionWhere = "${FeatureTable.COLUMN_IS_FAVORITE} = 1";
    } else if (selectArgs.isVisited) {
      selectionWhere = "${FeatureTable.COLUMN_IS_VISITED} = 1";
    } else
      return getAll();

    List<String> queryTables = selectArgs.cityId != null ? [CityTable.TABLE_NAME] : [];
    return query(
      "${getSelectQuery()} and $selectionWhere",
      getEngagedTables() + queryTables,
    );
  }
}
