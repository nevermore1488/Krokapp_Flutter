import 'dart:io';

import 'package:flutter/material.dart';

enum BuildType {krokapp, bnr}

class Resources {
  static final COLOR_TEXT = Color.fromARGB(255, 60, 60, 60);
  static final COLOR_TEXT_PRIMARY = COLOR_TEXT;

  static final COLOR_ICON = Color.fromARGB(255, 125, 125, 125);
  static final COLOR_ICON_PRIMARY = COLOR_TEXT;

  static final GOOGLE_MAP_API_KEY = "AIzaSyAaxz0y3SvUkDYxkdxKxeEbmJ2XXVaLU8Q";

  BuildContext _context;
  BuildType buildType;

  late Color colorPrimary;
  late Color colorPrimaryAccent;
  late String appLogoPath;

  Resources(this._context, this.buildType) {
    switch(buildType) {
      case BuildType.krokapp: {
        colorPrimary = Colors.orange;
        colorPrimaryAccent = Colors.orangeAccent;
        appLogoPath = 'assets/icons/ic_krokapp.png';
        break;
      }
      case BuildType.bnr: {
        colorPrimary = Colors.red;
        colorPrimaryAccent = Colors.redAccent;
        appLogoPath = 'assets/icons/ic_bnr.png';
        break;
      }
      default: throw ArgumentError("No such build type");
    }
  }

}

class MyHttpOverrides extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
