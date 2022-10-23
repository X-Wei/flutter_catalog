import 'dart:io' show Platform;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

// ignore_for_file: constant_identifier_names

late final PackageInfo kPackageInfo;
const APP_NAME = 'Flutter Catalog';
final kAppIcon =
    Image.asset('res/images/app_icon.png', height: 64.0, width: 64.0);
const APP_DESCRIPTION = 'An app showcasing Flutter components, with '
    'side-by-side source code view.'
    '\n\nDeveloped by X.Wei.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/X-Wei/flutter_catalog';
const AUTHOR_SITE = 'http://x-wei.github.io';
const APPSTORE_URL =
    'https://apps.apple.com/in/app/flutter-catalog/id1602928862';

final kPlatformType = getCurrentPlatformType();
// Whether the app is running on mobile phones (Android/iOS)
final kIsOnMobile =
    {PlatformType.Android, PlatformType.iOS}.contains(kPlatformType);

final kIsMobileOrWeb = kIsWeb ||
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.android;

final kAnalytics = kIsMobileOrWeb ? FirebaseAnalytics.instance : null;

/// ! Adapted from https://www.flutterclutter.dev/flutter/tutorials/how-to-detect-what-platform-a-flutter-app-is-running-on/2020/127/
enum PlatformType { Web, iOS, Android, MacOS, Fuchsia, Linux, Windows, Unknown }

PlatformType getCurrentPlatformType() {
  // ! `Platform` is not available on web, so we must check web first.
  if (kIsWeb) {
    return PlatformType.Web;
  }

  if (Platform.isMacOS) {
    return PlatformType.MacOS;
  }

  if (Platform.isFuchsia) {
    return PlatformType.Fuchsia;
  }

  if (Platform.isLinux) {
    return PlatformType.Linux;
  }

  if (Platform.isWindows) {
    return PlatformType.Windows;
  }

  if (Platform.isIOS) {
    return PlatformType.iOS;
  }

  if (Platform.isAndroid) {
    return PlatformType.Android;
  }

  return PlatformType.Unknown;
}
