import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'constants.dart';
import 'firebase_options.dart';
import 'my_app_settings.dart';
import 'my_main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsMobileOrWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseUIAuth.configureProviders([
      GoogleProvider(
        clientId:
            '785184947614-k4q21aq3rmasodkrj5gjs9qtqtkp89tt.apps.googleusercontent.com',
      ),
      EmailAuthProvider(),
      AppleProvider(),
    ]);
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (kIsOnMobile) {
      await MobileAds.instance.initialize();
    }
  }
  kPackageInfo = await PackageInfo.fromPlatform();
  final settings = await MyAppSettings.create();
  runApp(
    ProviderScope(
      overrides: [mySettingsProvider.overrideWith((ref) => settings)],
      child: MyMainApp(settings),
    ),
  );
}
