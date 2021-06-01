import 'package:flutter/material.dart';
import 'package:krokapp_multiplatform/business/init/db_helper.dart';
import 'package:krokapp_multiplatform/business/init/locale_helper.dart';
import 'package:krokapp_multiplatform/data/api.dart';
import 'package:krokapp_multiplatform/data/db/dao/languages_dao.dart';
import 'package:krokapp_multiplatform/data/db/observable_db_executor.dart';
import 'package:krokapp_multiplatform/data/repositories/languages_repository.dart';

class AppInitializer {
  late ObservableDatabaseExecutor dbExecutor;
  late Locale selectedLocale;

  Future<bool> initApp() async {
    dbExecutor = ObservableDatabaseExecutor(await DbHelper().obtainDb());
    LocaleHelper localeHelper = LocaleHelper(
      LanguagesRepository(
        LanguagesApiImpl(),
        LanguagesDaoImpl(dbExecutor),
      ),
    );
    selectedLocale = await localeHelper.getLocale(WidgetsBinding.instance!.window.locales);
    return true;
  }
}
