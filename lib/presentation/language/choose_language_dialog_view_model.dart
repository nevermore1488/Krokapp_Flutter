import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/business/usecases/language_use_case.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:rxdart/rxdart.dart';

class ChooseLanguageDialogViewModel {
  LanguageUseCase _languageUseCase;
  BuildContext _context;

  final _selectedLangauge = BehaviorSubject<Language>();

  ChooseLanguageDialogViewModel(
    this._languageUseCase,
    this._context,
  );

  Stream<SelectableLanguages> getSelectableLanguages() => _languageUseCase.getLanguages().switchMap(
        (value) => _selectedLangauge.stream.mergeWith(
          [_languageUseCase.getCurrentLanguage()],
        ).map(
          (event) => SelectableLanguages(languages: value, selectedLanguage: event),
        ),
      );

  void onNewLanguageSelected(Language language) {
    _selectedLangauge.value = language;
  }

  void onOkPressed() {
    if (_selectedLangauge.hasValue) {
      _languageUseCase.setCurrentLanguage(_selectedLangauge.value);
    }
    //closing dialog
    Navigator.pop(_context);
    //closing drawer
    Navigator.pop(_context);
  }

  void onCancelPressed() {
    Navigator.pop(_context);
  }
}

class SelectableLanguages {
  List<Language> languages;
  Language selectedLanguage;

  SelectableLanguages({
    required this.languages,
    required this.selectedLanguage,
  });
}
