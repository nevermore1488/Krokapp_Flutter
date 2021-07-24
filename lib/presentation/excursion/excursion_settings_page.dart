import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/data/pojo/tag.dart';
import 'package:krokapp_multiplatform/presentation/excursion/excursion_settings_view_model.dart';
import 'package:krokapp_multiplatform/ui/snapshot_view.dart';
import 'package:provider/provider.dart';

class ExcursionSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExcursionSettingsViewModel vm = Provider.of(context);
    return StreamBuilder<List<Tag>>(
      builder: (context, snapshot) => SnapshotView<List<Tag>>(
        snapshot: snapshot,
        onHasData: (data) => Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.nav_menu_item_excursion_settings,
            ),
          ),
          body: ListView(
            children: data
                .map((e) => CheckboxListTile(
                      value: e.isChecked,
                      title: Text(e.name),
                      onChanged: (b) => {},
                    ))
                .toList(),
          ),
        ),
      ),
      stream: vm.getTags(),
    );
  }
}
