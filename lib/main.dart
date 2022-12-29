import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import './constants.dart';
import './firebase_options.dart';
import './my_app_settings.dart';
import './my_main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsMobileOrWeb) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    await MobileAds.instance.initialize();
  }
  kPackageInfo = await PackageInfo.fromPlatform();
  final settings = await MyAppSettings.create();
  // This dir will be "$USER/Documents" on Linux.
  final appDir = await getApplicationDocumentsDirectory();
  runApp(
    ProviderScope(
      overrides: [
        mySettingsProvider.overrideWithProvider(
          ChangeNotifierProvider((ref) => settings),
        ),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (_) => MyMainApp(settings),
        tools: [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(
            onScreenshot: screenshotAsFiles(appDir),
          ),
        ],
      ),
    ),
  );
}
