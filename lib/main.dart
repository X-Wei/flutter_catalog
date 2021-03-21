import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './constants.dart';
import './my_main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsOnMobile) {
    await Firebase.initializeApp();
  }
  final sharedPref = await SharedPreferences.getInstance();
  runApp(MyMainApp(sharedPref));
}
