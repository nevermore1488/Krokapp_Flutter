import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/pojo/language.dart';
import 'package:krokapp_multiplatform/presentation/language/choose_language_dialog_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class ChooseLanguageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChooseLanguageDialogViewModel vm = Provider.of(context);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.nav_menu_item_language),
      content: StreamBuilder<SelectableLanguages>(
        stream: vm.getSelectableLanguages(),
        builder: (context, snapshot) => SnapshotView<SelectableLanguages>(
          snapshot: snapshot,
          onHasData: (data) => Column(
            mainAxisSize: MainAxisSize.min,
            children: data.languages
                .map((e) => RadioListTile<Language>(
                      title: Text(e.name),
                      value: e,
                      groupValue: data.selectedLanguage,
                      selected: data.selectedLanguage.id == e.id,
                      onChanged: (value) {
                        if (value != null) vm.onNewLanguageSelected(value);
                      },
                    ))
                .toList(),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => vm.onCancelPressed,
        ),
        TextButton(
          child: Text("OK"),
          onPressed: () => vm.onOkPressed(),
        ),
      ],
    );
  }
}
