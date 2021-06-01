import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';
import 'package:krokapp_multiplatform/data/repositories/data_provider.dart';

class LanguagesRepository {
  LanguagesApi _api;
  LanguagesDao _dao;

  late DataProvider<List<LanguageTable>> languagesProvider;

  LanguagesRepository(
    this._api,
    this._dao,
  ) {
    languagesProvider = DataProvider(
      () => _dao.getAll(),
      (data) => _dao.replaceBy(data),
      () => _api.getLanguages().first,
      (data) => data.isNotEmpty,
    );
  }

  Stream<List<LanguageTable>> getLanguages() => languagesProvider.getData();

  Future<int?> getCurrentLanguageId() => _dao.getCurrentLanguageId();

  Future<void> setCurrentLanguageId(int langId) => _dao.setCurrentLanguageId(langId);
}
