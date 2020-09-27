package io.github.x_wei.flutter_catalog;

import android.os.Bundle;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterFragmentActivity {
  // Adding this to be able to use multidex for API version <21.
  // C.f. https://developer.android.com/studio/build/multidex.
  @Override
  protected void attachBaseContext(android.content.Context base) {
    super.attachBaseContext(base);
    androidx.multidex.MultiDex.install(this);
  }
}
