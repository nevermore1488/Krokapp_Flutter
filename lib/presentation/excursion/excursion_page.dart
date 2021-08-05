import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/presentation/excursion/excursion_view_model.dart';
import 'package:krokapp_multiplatform/presentation/map/map_page.dart';
import 'package:krokapp_multiplatform/presentation/map/map_view_model.dart';
import 'package:provider/provider.dart';

class ExcursionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExcursionViewModel vm = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.excursion_title),
        actions: [
          IconButton(
            onPressed: () => vm.onSettingsIconClicked(),
            icon: Icon(
              Icons.settings,
              semanticLabel: AppLocalizations.of(context)!
                  .nav_menu_item_excursion_settings,
            ),
          )
        ],
      ),
      body: Provider<MapViewModel>(
        create: (context) => vm,
        child: MapPage(),
      ),
    );
  }
}
