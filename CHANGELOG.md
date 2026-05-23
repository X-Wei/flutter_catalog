# Change Log

## v3.9.2
[2026-05-23]
- **iOS Build Fix**: Resolved iOS build by disabling Swift Package Manager (conflict between `google_mobile_ads` (CocoaPods) and `webview_flutter_wkwebview` (SPM))
- Fixed missing `cupertino.dart` import in `lib/themes.dart` for `CupertinoPageTransitionsBuilder`
- Updated iOS CI workflow to disable SPM before `pod install`

## v3.9.1
[2026-02-21]
- **Android 16KB Page Size Compatibility**: Migrated from `edge_detection_plus` to `google_mlkit_document_scanner` to support Android 16KB page size requirements
- **ML Kit Examples Restructure**: Split the combined Google ML Kit example into 5 separate, focused examples:
  - ML Kit Image Labeling (`aiml_mlkit_image_labeling_ex.dart`)
  - ML Kit Text Recognition (`aiml_mlkit_text_recognition_ex.dart`)
  - ML Kit Barcode Scanning (`aiml_mlkit_barcode_scanning_ex.dart`)
  - ML Kit Face Detection (`aiml_mlkit_face_detection_ex.dart`)
  - ML Kit Document Scanner (`aiml_mlkit_doc_scanner_ex.dart`)
- **Code Quality**: Simplified and cleaned up all examples for better readability and educational value
- **UI Improvements**: Removed AppBars from examples, improved layouts and user experience
- Removed OpenCV dependencies that were incompatible with Google Play Store requirements
- Enhanced Android build configuration for modern requirements
- Removed legacy edge detection example that used incompatible OpenCV library

## v3.9.0
[2026-02-14]
- migrate to latest packages and build with flutter 3.41.1
- add unit and widget tests and github CI actions
- refactor and simplify code
- migrate google mlkit packages
- add back edge_detection example

## v3.8.3
[2024-11-11]
- migrate to latest packages and build with flutter 3.24.4
- fix content-obscure-ads policy issue

## v3.8.2
[2024-07-14]
1. re-enable chatGPT demo
2. add reusabble UI: MyTextComposer 
3. make MyValuePickerTile responsive
4. fix local_auth issue (#153)
5. add fabOffset for admob policy

## v3.8.1
[2024-06-09]
- add new examples: AI chat w/ Groq, download file via dio, show timeline UI
- fix bug in firebase chatroom and IAP example 
- add reusable class/functions across examples
- add widget_with_codeview as git subtree
- build with latest flutter 3.22.2
- upgrade packages & other fixes


## v3.7.0
[2023-09-18]
- update app icon to resolve trademark issue(#144)
- upgrade to latest package version and build with flutter 3.13.4

## v3.6.0
[2023-04-02]
- Add ChatGPT example
- Remember last-opened tab
- Show new routes badge at tab level
- Upgrade pacakges and built with Flutter 3.7.9

## v3.5.3
[2023-01-17]
- Add new heatmap calendar example
- Add like button example
- Add youtube player example

## v3.5.2
[2022-12-11]
- add StoreSecretsExample example on how to store secrets
- store ad unit ids in (git-ignored) .env file

## v3.5.1
[2022-12-05]
- add In-App-Purchase (IAP) example
- manage user-Purchases with firstore/riverpod
- add device_preview example
- add Grey App example: R.I.P. for Elder.

## v3.4.0
[2022-11-06]
- Add new "In-Action" tab to home page.
- Add new examples:
  - `IntroScreenExample`
  - `WhatsNewExample`
  - `InAppReviewExample`
  - `SharePlusExample`
  - `MyOtherAppsExample`
- Update Ads demo
  - add option to turn on/off the Ads personalization
  - display number of rewarded coins in RewaredAds demo

## v3.3.0
[2022-10-23]
- better source code syntax highlighting with [widget_with_codeview v3.0.1](https://pub.dev/packages/widget_with_codeview)
- migrate to dart 2.17
- add `TypographyExample`
- add option to change code theme for `CodeHighlightExample`
- other improvements and fixups

## v3.2.0
[2022-10-21]
- add monetization examples
  - banner ads
  - interstitial ads
  - rewarded ads
- add `FlutterFireLoginUiExample`
- add `SelectableExample`
- add crashlytics and analytics event logging
- upgrade packages & fix firestore error