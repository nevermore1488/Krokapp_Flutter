import 'package:krokapp_multiplatform/data/db/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tables/feature_table.dart';

abstract class FeatureDao extends CommonDao<FeatureTable> {}

class FeatureDaoImpl extends CommonDaoImpl<FeatureTable> implements FeatureDao {
  FeatureDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          FeatureTable.TABLE_NAME,
          FeaturesJsonConverter(),
        );
}
