import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/dao/current_language_id_dao.dart';
import 'package:krokapp_multiplatform/data/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/data/tables/current_language_id_table.dart';
import 'package:krokapp_multiplatform/data/tables/languages_table.dart';
import 'package:krokapp_multiplatform/utils//extentions.dart';

class LanguagesRepository {
  LanguagesApi _api;
  LanguagesDao _languagesDao;
  CurrentLanguageIdDao _currentLanguageIdDao;

  LanguagesRepository(
    this._api,
    this._languagesDao,
    this._currentLanguageIdDao,
  );

  Stream<Language?> getCurrentLanguage() =>
      _languagesDao.getAll().mapFirstOrNull().map((event) => event?.toLanguage());

  Stream<List<Language>> getLanguages() => _languagesDao.getVeryAll().asLanguages();

  Future<List<Language>> loadLanguages() async {
    List<LanguagesTable> languages = await _languagesDao.getVeryAll().first;
    if (languages.isEmpty) {
      languages = await _api.getLanguages().first;
      _languagesDao.add(languages);
    }
    return languages.map((e) => e.toLanguage()).toList();
  }

  Future<void> setCurrentLanguage(Language language) async {
    await _currentLanguageIdDao.deleteAll();
    await _currentLanguageIdDao.add([CurrentLanguageIdTable(language.id)]);
  }

}
