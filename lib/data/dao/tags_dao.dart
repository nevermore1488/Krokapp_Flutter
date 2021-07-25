import 'package:krokapp_multiplatform/data/dao/common_dao.dart';
import 'package:krokapp_multiplatform/data/dao/localized_dao.dart';
import 'package:krokapp_multiplatform/data/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:krokapp_multiplatform/data/tables/tag_features_table.dart';
import 'package:krokapp_multiplatform/data/tables/tags_table.dart';

abstract class TagsDao extends CommonDao<TagsTable> {
  Stream<List<Tag>> getTags();
}

class TagsDaoImpl extends CommonDaoImpl<TagsTable> implements TagsDao {
  TagsDaoImpl(ObservableDatabaseExecutor obsDbExecutor)
      : super(
          obsDbExecutor,
          TagsTable.TABLE_NAME,
          TagsJsonConverter(),
        );

  @override
  Stream<List<Tag>> getTags() => obsDbExecutor.observableRawQuery(
        "SELECT * FROM $tableName LEFT JOIN ${TagFeaturesTable.TABLE_NAME} "
        "ON $tableName.${TagsTable.COLUMN_TAG_ID} "
        "= ${TagFeaturesTable.TABLE_NAME}.${TagFeaturesTable.COLUMN_FEATURED_TAG_ID} "
        "WHERE ${TagsTable.COLUMN_LANG} = (${LocalizedDao.SELECT_CURRENT_LANGUAGE_TABLE_CLAUSE})",
        [tableName, TagFeaturesTable.TABLE_NAME],
      ).map((event) => event
          .map((e) => Tag(
                id: e[TagsTable.COLUMN_TAG_ID] as int,
                name: e[TagsTable.COLUMN_TAG_LABEL] as String,
                isChecked: e[TagFeaturesTable.COLUMN_FEATURED_TAG_ID] != null,
              ))
          .toList());
}
