import 'package:flutter/material.dart';

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
              child: Text(
                'KrokApp, your guide',
                style: TextStyle(color: Colors.white, fontSize: 21),
              ),
            ),
            _createMenuGroupTitle("Settings"),
            _createMenuItem("Languages", Icons.language, () {}),
            _createMenuItem("Excursion Setting", Icons.settings, () {}),
            Divider(),
            _createMenuGroupTitle("Personal"),
            _createMenuItem("Bookmarks", Icons.favorite_outline, () {}),
            _createMenuItem("Downloads", Icons.download_outlined, () {}),
            _createMenuItem("Visited", Icons.check_circle_outline, () {}),
            Divider(),
            _createMenuGroupTitle("Info"),
            _createMenuItem("About Us", Icons.info_outline, () {}),
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
