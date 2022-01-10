import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './constants.dart';
import './firebase_options.dart';
import './my_app_settings.dart';
import './my_main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsOnMobile || kIsWeb) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
  final settings = await MyAppSettings.create();
  runApp(MyMainApp(settings));
}
