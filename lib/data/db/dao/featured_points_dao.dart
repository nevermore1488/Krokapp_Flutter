import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/city_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/feature_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/featured_point_table.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/point_table.dart';

abstract class FeaturedPointsDao extends CommonDao<FeaturedPointTable> {
  Stream<List<FeaturedPointTable>> getPointsOfCity(int cityId);

  Stream<List<FeaturedPointTable>> getPointById(int pointId);

  Stream<List<FeaturedPointTable>> getFavorites();

  Stream<List<FeaturedPointTable>> getVisited();
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
  Stream<List<FeaturedPointTable>> getPointsOfCity(int cityId) => query(
        "${getSelectQuery()} and ${PointTable.COLUMN_CITY_ID} = $cityId",
        getEngagedTables() + [CityTable.TABLE_NAME],
      );

  @override
  Stream<List<FeaturedPointTable>> getPointById(int pointId) => query(
        "${getSelectQuery()} and ${PointTable.COLUMN_PLACE_ID} = $pointId",
        getEngagedTables(),
      );

  @override
  Stream<List<FeaturedPointTable>> getFavorites() => query(
        "${getSelectQuery()} and ${FeatureTable.COLUMN_IS_FAVORITE} = 1",
        getEngagedTables(),
      );

  @override
  Stream<List<FeaturedPointTable>> getVisited() => query(
        "${getSelectQuery()} and ${FeatureTable.COLUMN_IS_VISITED} = 1",
        getEngagedTables(),
      );
}
