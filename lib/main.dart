import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/presentation/app/init_app.dart';

void main() {
  // needed for fixing images uploading error on api < 23
  HttpOverrides.global = new MyHttpOverrides();
  runApp(InitApp());
}

class MyHttpOverrides extends HttpOverrides {

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
