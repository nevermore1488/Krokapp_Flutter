import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/current_language_id_dao.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/current_language_id_table.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/data/pojo/language_table.dart';
import 'package:krokapp_multiplatform/utils//extentions.dart';

class LanguagesRepository {
  LanguagesApi _api;
  LanguagesDao _languagesDao;
  CurrentLanguageIdDao _currLangDao;

  LanguagesRepository(
    this._api,
    this._languagesDao,
    this._currLangDao,
  );

  Stream<Language?> getCurrentLanguage() =>
      _languagesDao.getAll().firstOrNull().map((event) => event?.toLanguage());

  Stream<List<Language>> getLanguages() => _languagesDao.getVeryAll().asLanguages();

  Future<List<Language>> loadLanguages() async {
    List<LanguageTable> languages = await _languagesDao.getVeryAll().first;
    if (languages.isEmpty) {
      languages = await _api.getLanguages().first;
      _languagesDao.replaceBy(languages);
    }
    return languages.map((e) => e.toLanguage()).toList();
  }

  Future<void> setCurrentLanguage(Language language) =>
      _currLangDao.replaceBy([CurrentLanguageIdTable(language.id)]);
}
