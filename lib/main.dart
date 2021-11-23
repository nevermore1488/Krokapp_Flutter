import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:krokapp_multiplatform/presentation/app/init_app.dart';
import 'package:krokapp_multiplatform/resources.dart';

void main(List<String> args) {
  // needed for fixing images uploading error on api < 23
  HttpOverrides.global = new MyHttpOverrides();
  runApp(InitApp(Resources()));
}
