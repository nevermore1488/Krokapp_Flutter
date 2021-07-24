import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/presentation/app/krok_app.dart';
import 'package:krokapp_multiplatform/presentation/language/choose_language_dialog.dart';
import 'package:krokapp_multiplatform/presentation/language/choose_language_dialog_view_model.dart';
import 'package:provider/provider.dart';

class NavigationMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(context),
            _createMenuGroupTitle(
                context, AppLocalizations.of(context)!.nav_menu_group_settings),
            _createChooseLanguageItem(context),
            _createExcursionItem(context),
            Divider(),
            _createMenuGroupTitle(
                context, AppLocalizations.of(context)!.nav_menu_group_personal),
            _createFavoritesItem(context),
            // _createMenuItem("Downloads", Icons.download_outlined, () {}),
            _createVisitedItem(context),
            Divider(),
            _createAboutUsItem(context),
          ],
        ),
      );

  Widget _createHeader(BuildContext context) => DrawerHeader(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Image.asset('drawables/krok_icon.png'),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.nav_menu_title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      );

  Widget _createChooseLanguageItem(BuildContext context) => _createMenuItem(
        AppLocalizations.of(context)!.nav_menu_item_language,
        Icons.language,
        () {
          Navigator.push(
            context,
            DialogRoute(
              context: context,
              builder: (_) => Provider(
                create: (_) => ChooseLanguageDialogViewModel(
                    Provider.of(context), context),
                child: ChooseLanguageDialog(),
              ),
            ),
          );
        },
      );

  Widget _createAboutUsItem(BuildContext context) => _createMenuItem(
        AppLocalizations.of(context)!.nav_menu_item_about_us,
        Icons.info_outline,
        () {
          Navigator.pushNamed(context, KrokAppRoutes.ABOUT_US);
        },
      );

  Widget _createFavoritesItem(BuildContext context) => _createMenuItem(
        AppLocalizations.of(context)!.nav_menu_item_bookmarks,
        Icons.favorite_outline,
        () {
          Navigator.pushNamed(context, KrokAppRoutes.FAVORITES);
        },
      );

  Widget _createVisitedItem(BuildContext context) => _createMenuItem(
        AppLocalizations.of(context)!.nav_menu_item_visited,
        Icons.check_circle_outline,
        () {
          Navigator.pushNamed(context, KrokAppRoutes.VISITED);
        },
      );

  Widget _createExcursionItem(BuildContext context) => _createMenuItem(
        AppLocalizations.of(context)!.nav_menu_item_excursion_settings,
        Icons.pin_drop_outlined,
        () {
          Navigator.pushNamed(context, KrokAppRoutes.EXCURSION);
        },
      );

  Widget _createMenuGroupTitle(BuildContext context, String title) => Padding(
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: Text(title),
      );

  Widget _createMenuItem(String name, IconData iconData, Function()? onClick) =>
      ListTile(
        title: Text(name),
        leading: Icon(iconData),
        onTap: onClick,
      );
}
