package io.github.x_wei.flutter_catalog

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine) // add this line
  }
}
