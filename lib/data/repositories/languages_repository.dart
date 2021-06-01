import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';

class LanguagesRepository {
  LanguagesApi _api;
  LanguagesDao _dao;

  LanguagesRepository(
    this._api,
    this._dao,
  );

  Stream<List<LanguageTable>> loadLanguagesFromStorage() => _dao.getAll();

  Stream<List<LanguageTable>> loadLanguagesFromRemote() => _api.getLanguages();

  Future<void> setLanguages(List<LanguageTable> languages) => _dao.replaceBy(languages);

  Future<int?> getCurrentLanguageId() => _dao.getCurrentLanguageId();

  Future<void> setCurrentLanguageId(int langId) => _dao.setCurrentLanguageId(langId);
}
