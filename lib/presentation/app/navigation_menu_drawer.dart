import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';

class NavigationMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Image.asset('drawables/krok_icon.png', color: Colors.white),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.nav_menu_title,
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                ],
              ),
            ),
            _createMenuGroupTitle(AppLocalizations.of(context)!.nav_menu_group_settings),
            _createMenuItem(
              AppLocalizations.of(context)!.nav_menu_item_language,
              Icons.language,
              () {},
            ),
            /* _createMenuItem("Excursion Setting", Icons.settings, () {}),*/
            Divider(),
            /*  _createMenuGroupTitle("Personal"),
            _createMenuItem("Bookmarks", Icons.favorite_outline, () {}),
            _createMenuItem("Downloads", Icons.download_outlined, () {}),
            _createMenuItem("Visited", Icons.check_circle_outline, () {}),
            Divider(),
            _createMenuGroupTitle("Info"),
            _createMenuItem("About Us", Icons.info_outline, () {}),*/
          ],
        ),
      );

  Widget _createMenuGroupTitle(String title) => Padding(
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
        child: Text(
          title,
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      );

  Widget _createMenuItem(String name, IconData iconData, Function? onClick) => ListTile(
        title: Text(name),
        leading: Icon(iconData),
        onTap: () => onClick,
      );
}
