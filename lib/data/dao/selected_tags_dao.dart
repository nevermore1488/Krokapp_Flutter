import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/selected_tags_table.dart';

abstract class SelectedTagsDao extends CommonDao<SelectedTagsTable> {}

class SelectedTagsDaoImpl extends CommonDaoImpl<SelectedTagsTable> implements SelectedTagsDao {
  SelectedTagsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          SelectedTagsTable.TABLE_NAME,
          SelectedTagsJsonConverter(),
        );
}
