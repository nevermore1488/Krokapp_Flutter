import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/features_table.dart';

abstract class FeatureDao extends CommonDao<FeaturesTable> {}

class FeatureDaoImpl extends CommonDaoImpl<FeaturesTable> implements FeatureDao {
  FeatureDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          FeaturesTable.TABLE_NAME,
          FeaturesJsonConverter(),
        );
}
