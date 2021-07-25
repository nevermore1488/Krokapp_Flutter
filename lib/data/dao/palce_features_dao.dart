import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/place_features_table.dart';

abstract class PlaceFeaturesDao extends CommonDao<PlaceFeaturesTable> {}

class PlaceFeaturesDaoImpl extends CommonDaoImpl<PlaceFeaturesTable>
    implements PlaceFeaturesDao {
  PlaceFeaturesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          PlaceFeaturesTable.TABLE_NAME,
          PlaceFeaturesJsonConverter(),
        );
}
