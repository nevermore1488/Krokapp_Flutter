import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:krokapp_multiplatform/ui/custom_animated_container.dart';

enum BuildType { krokapp, bnr }

class Resources {
  static final COLOR_TEXT = Color.fromARGB(255, 60, 60, 60);
  static final COLOR_TEXT_PRIMARY = COLOR_TEXT;

  static final COLOR_ICON = Color.fromARGB(255, 125, 125, 125);
  static final COLOR_ICON_PRIMARY = COLOR_TEXT;

  static const _KROK_API = "http://krokapp.by/api/";
  static const _BNR_API = "http://bnr.krokam.by/api/";

  static final GOOGLE_MAP_API_KEY = "AIzaSyAaxz0y3SvUkDYxkdxKxeEbmJ2XXVaLU8Q";

  BuildType _buildType;

  late Color colorPrimary;
  late String appLogoPath;
  late String baseUrl;
  late String getCitiesPath;
  late String getPointsPath;
  late bool isLoadTags;
  late bool isSetupExcursionOnPoints;
  late bool isShowExcursionMenuItem;
  late AnimationType splashScreenLogoAnimationType;

  var getNavigationMenuTitle = (BuildContext context) => "";

  Resources(this._buildType) {
    switch (_buildType) {
      case BuildType.krokapp:
        {
          colorPrimary = Colors.orange;
          appLogoPath = 'assets/icons/ic_krokapp.png';
          baseUrl = _KROK_API;
          getCitiesPath = 'get_cities/';
          getPointsPath = 'get_points/';
          isLoadTags = true;
          isSetupExcursionOnPoints = false;
          isShowExcursionMenuItem = true;
          splashScreenLogoAnimationType = AnimationType.rotate;
          getNavigationMenuTitle =
              (context) => AppLocalizations.of(context)!.nav_menu_title;
          break;
        }
      case BuildType.bnr:
        {
          colorPrimary = Colors.red;
          appLogoPath = 'assets/icons/ic_bnr.png';
          baseUrl = _BNR_API;
          getCitiesPath = 'get_sections/';
          getPointsPath = 'get_exhibits/';
          isLoadTags = false;
          isSetupExcursionOnPoints = true;
          isShowExcursionMenuItem = false;
          splashScreenLogoAnimationType = AnimationType.scale;
          getNavigationMenuTitle =
              (context) => AppLocalizations.of(context)!.nav_menu_title_bnr;
          break;
        }
      default:
        throw _createBuildTypeException();
    }
  }

  ArgumentError _createBuildTypeException() =>
      ArgumentError("No such build type");
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
