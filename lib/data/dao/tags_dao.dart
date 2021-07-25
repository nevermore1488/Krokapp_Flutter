import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';

abstract class TagsDao extends CommonDao<TagsTable> {}

class TagsDaoImpl extends CommonDaoImpl<TagsTable> implements TagsDao {
  TagsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          TagsTable.TABLE_NAME,
          TagsJsonConverter(),
        );
}
