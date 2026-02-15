import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import 'my_app_routes.dart' show kAppRoutingTable;
import 'my_app_settings.dart';
import 'themes.dart';

class MyMainApp extends StatelessWidget {
  final MyAppSettings settings;
  const MyMainApp(this.settings, {super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: !kReleaseMode, // devicePreview disabled for release mode
      builder: (_) => MaterialApp(
        title: 'Flutter Catalog',
        useInheritedMediaQuery: true,
        theme: settings.isDarkMode ? kDarkTheme : kLightTheme,
        routes: kAppRoutingTable,
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
      ),
      tools: [
        ...DevicePreview.defaultTools,
        if (!kIsWeb) // store screenshot to documents folder if not on web
          DevicePreviewScreenshot(
            onScreenshot: (ctx, scrn) async {
              final appDir = await getApplicationDocumentsDirectory();
              if (ctx.mounted) screenshotAsFiles(appDir)(ctx, scrn);
            },
          ),
      ],
    );
  }
}
