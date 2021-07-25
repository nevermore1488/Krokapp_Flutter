import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/tag_features_table.dart';

abstract class TagFeaturesDao extends CommonDao<TagFeaturesTable> {}

class TagFeaturesDaoImpl extends CommonDaoImpl<TagFeaturesTable>
    implements TagFeaturesDao {
  TagFeaturesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          TagFeaturesTable.TABLE_NAME,
          TagFeaturesJsonConverter(),
        );
}
