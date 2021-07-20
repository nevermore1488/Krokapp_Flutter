import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/selected_tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_dao.dart';
import 'package:krokapp_multiplatform/data/dao/tags_of_places_dao.dart';
import 'package:krokapp_multiplatform/data/tables/selected_tags_table.dart';

class TagsRepository {
  TagsApi _tagsApi;
  TagsDao _tagsDao;
  SelectedTagsDao _selectedTagsDao;
  TagsOfPlacesDao _tagsOfPlacesDao;

  TagsRepository(
    this._tagsApi,
    this._tagsDao,
    this._selectedTagsDao,
    this._tagsOfPlacesDao,
  );

  Future<void> loadTags() async {
    var tags = await _tagsDao.getAll().first;
    if (tags.isEmpty) {
      tags = await _tagsApi.getTags().first;
      _tagsDao.add(tags);
    }
  }

  Future<void> saveSelectedTags(List<SelectedTagsTable> tags) async {
    _selectedTagsDao.add(tags);
  }
}
