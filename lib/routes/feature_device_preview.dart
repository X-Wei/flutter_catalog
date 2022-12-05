import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';

class DevicePreviewExample extends StatefulWidget {
  const DevicePreviewExample({super.key});

  @override
  State<DevicePreviewExample> createState() => _DevicePreviewExampleState();
}

class _DevicePreviewExampleState extends State<DevicePreviewExample> {
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: true,
      builder: (_) => _appUI(),
      tools: const [
        ...DevicePreview.defaultTools,
        // ! We can add other tools like taking screenshots
        // DevicePreviewScreenshot(onScreenshot: screenshotAsFiles(appDir)),
      ],
    );
  }

  Widget _appUI() {
    return MaterialApp(
      // ! Must set following 3 items to make DevicePreview work
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        appBar: AppBar(title: Text('My Awesome App')),
        body: Center(child: Image.asset('res/images/dart-side.png')),
      ),
    );
  }
}
