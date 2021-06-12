import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/tags_of_places_table.dart';

abstract class TagsOfPlacesDao extends CommonDao<TagsOfPlacesTable> {}

class TagsOfPlacesDaoImpl extends CommonDaoImpl<TagsOfPlacesTable> implements TagsOfPlacesDao {
  TagsOfPlacesDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          TagsOfPlacesTable.TABLE_NAME,
          TagsOfPlacesJsonConverter(),
        );
}
