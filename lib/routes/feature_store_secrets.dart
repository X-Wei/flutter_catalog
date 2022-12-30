import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'richtext_markdown_ex.dart';

class StoreSecretsExample extends StatefulWidget {
  const StoreSecretsExample({super.key});

  @override
  State<StoreSecretsExample> createState() => _StoreSecretsExampleState();
}

class _StoreSecretsExampleState extends State<StoreSecretsExample> {
  @override
  Widget build(BuildContext context) {
    return Markdown(
      onTapLink: (text, href, title) =>
          MarkdownExample.onTapLink(text, href, title, context),
      data: r'''
# Storing secrets with dart-define and define_env

## "dart-define" to store and use secret keys
We can define variables when building the app like so:

```sh
flutter build apk \
  --dart-define=MY_FIRST_KEY='abcdefg' \
  --dart-define=MY_SECOND_KEY='hijklmn'
```

The keys can be referenced in dart code by:

```dart
# ! NOTE: must add "const" to it, see https://github.com/flutter/flutter/issues/55870
String myKey = const String.fromEnvironment(
    'MY_FIRST_KEY',
    defaultValue: '',
  );
```

## Defining secrets in ".env" file

Having too many `dart-define`s is a bit hard to manage, so we use **[define_env](https://pub.dev/packages/define_env)** which reads the `.env` file to get the `dart-define`s.

We first add the secrets in the `.env` file:

```sh
MY_FIRST_KEY='abcdefg'
MY_SECOND_KEY='hijklmn'
```

Make sure to add the `.env` file to `.gitignore` to not check it in.

Then we can install and use `define_dev` to get the dart-defines:

```sh
# Install define_env
$ dart pub global activate define_env

# Get dart-defines
$ define_env      # generate dart define string and print it to stdout
$ define_env -c   # generate dart define string and copy to clipboard
```

In this example, I defined a **`MySecretsHelper` class** that returns the secrets, which can be used elsewhere.

## Other option

Another option to store secrets include ENVied package, where we use code generation 
to store and obfuscate secrets. For more details see [Andrea's tutorial](https://codewithandrea.com/articles/flutter-api-keys-dart-define-env-files).
''',
    );
  }
}

// ignore: avoid_classes_with_only_static_members
class MySecretsHelper {
  static String get bannerAdUnitId {
    // https://developers.google.com/admob/android/test-ads#sample_ad_units
    const kAndroidDebugAdId = 'ca-app-pub-3940256099942544/6300978111';
    // https://developers.google.com/admob/ios/test-ads#demo_ad_units
    const kIosDebugAdId = 'ca-app-pub-3940256099942544/2934735716';
    // ! Return test ad unit if we are in debug mode -- otherwise account might be banned!
    if (Platform.isAndroid) {
      return kDebugMode
          ? kAndroidDebugAdId
          : const String.fromEnvironment('AD_ID_ANDROID_BANNER',
              defaultValue: kAndroidDebugAdId);
    } else if (Platform.isIOS) {
      return kDebugMode
          ? kIosDebugAdId
          : const String.fromEnvironment('AD_ID_IOS_BANNER',
              defaultValue: kIosDebugAdId);
    }
    return '';
  }

  static String get interstitialAdUnitId {
    // https://developers.google.com/admob/android/test-ads#sample_ad_units
    const kAndroidDebugAdId = 'ca-app-pub-3940256099942544/1033173712';
    // https://developers.google.com/admob/ios/test-ads#demo_ad_units
    const kIosDebugAdId = 'ca-app-pub-3940256099942544/4411468910';
    if (Platform.isAndroid) {
      return kDebugMode
          ? kAndroidDebugAdId
          : const String.fromEnvironment('AD_ID_ANDROID_INTERSTITIAL',
              defaultValue: kAndroidDebugAdId);
    } else if (Platform.isIOS) {
      return kDebugMode
          ? kIosDebugAdId
          : const String.fromEnvironment('AD_ID_IOS_INTERSTITIAL',
              defaultValue: kIosDebugAdId);
    }
    return '';
  }

  static String get rewardedAdUnitId {
    // https://developers.google.com/admob/android/test-ads#sample_ad_units
    const kAndroidDebugAdId = 'ca-app-pub-3940256099942544/5224354917';
    // https://developers.google.com/admob/ios/test-ads#demo_ad_units
    const kIosDebugAdId = 'ca-app-pub-3940256099942544/1712485313';
    if (Platform.isAndroid) {
      return kDebugMode
          ? kAndroidDebugAdId
          : const String.fromEnvironment('AD_ID_ANDROID_REWARDED',
              defaultValue: kAndroidDebugAdId);
    } else if (Platform.isIOS) {
      return kDebugMode
          ? kIosDebugAdId
          : const String.fromEnvironment('AD_ID_IOS_REWARDED',
              defaultValue: kIosDebugAdId);
    }
    return '';
  }
}
