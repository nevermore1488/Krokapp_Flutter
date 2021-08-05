import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/tables/featured_tag_table.dart';
import 'package:krokapp_multiplatform/data/tables/tag_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';

abstract class FeaturedTagsDao extends CommonDao<FeaturedTagTable> {}

class FeaturedTagsDaoImpl extends LocalizedDao<FeaturedTagTable>
    implements FeaturedTagsDao {
  FeaturedTagsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          TagsTable.TABLE_NAME,
          FeaturedTagsJsonConverter(),
        );

  @override
  List<String> getEngagedTables() =>
      super.getEngagedTables() + [TagFeaturesTable.TABLE_NAME];

  @override
  String beforeWhereStatement() => "LEFT JOIN ${TagFeaturesTable.TABLE_NAME}"
      " ON ${TagsTable.TABLE_NAME}.${TagsTable.COLUMN_TAG_ID}"
      " = ${TagFeaturesTable.TABLE_NAME}.${TagFeaturesTable.COLUMN_FEATURED_TAG_ID}";
}
