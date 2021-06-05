import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.nav_menu_item_about_us),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: HtmlWidget(AppLocalizations.of(context)!.about_text),
            ),
          ],
        ),
      );
}
