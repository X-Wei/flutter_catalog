import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './my_main_app.dart';

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  final sharedPref = await SharedPreferences.getInstance();
  runApp(MyMainApp(sharedPref));
}
