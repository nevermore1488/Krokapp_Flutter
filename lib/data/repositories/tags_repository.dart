import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/featured_tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tag_features_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_of_places_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:krokapp_multiplatform/data/tables/featured_tag_table.dart';
import 'package:krokapp_multiplatform/data/tables/tag_features_table.dart';
import 'package:sqflite/sqflite.dart';

class TagsRepository {
  TagsApi _tagsApi;
  TagsDao _tagsDao;
  FeaturedTagsDao _featuredTagsDao;
  TagFeaturesDao _tagFeaturesDao;
  TagsOfPlacesDao _tagsOfPlacesDao;

  TagsRepository(
    this._tagsApi,
    this._tagsDao,
    this._featuredTagsDao,
    this._tagFeaturesDao,
    this._tagsOfPlacesDao,
  );

  Stream<List<Tag>> getTags() => _featuredTagsDao.getAll().asTags();

  Future<void> loadTags() async {
    var tags = await _tagsDao.getAll().first;
    if (tags.isEmpty) {
      tags = await _tagsApi.getTags().first;
      final checkedTags =
          tags.map((e) => TagFeaturesTable(e.tagId, 1)).toList();

      _tagsDao.add(tags);
      _tagFeaturesDao.add(checkedTags, onConflict: ConflictAlgorithm.ignore);
    }
  }

  Future<void> saveSelectedTags(List<TagFeaturesTable> tags) async {
    _tagFeaturesDao.add(tags);
  }
}
