# widget_with_codeview

[![pub package](https://img.shields.io/pub/v/widget_with_codeview.svg)](https://pub.dartlang.org/packages/widget_with_codeview)
![GitHub](https://img.shields.io/github/license/x-wei/widget_with_codeview.svg)

A widget with side-by-side source code view. Extracted from the
[flutter-catalog](https://github.com/X-Wei/flutter_catalog/) open-source app.

<img src="https://github.com/X-Wei/flutter_catalog/blob/master/screenshots/Screenshot_1541613193.png?raw=true" width="240px" />
<img src="https://github.com/X-Wei/flutter_catalog/blob/master/screenshots/Screenshot_1541613197.png?raw=true" width="240px" />

## Usage

First make sure to add the source file to the app's assets by editing `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  widget_with_codeview:
flutter:
  assets:
    # Include a single source code file:
    - lib/my_awesome_source_code.dart
    # Include all files under a subfoler by adding trailing "/":
    - lib/my_awesome_source_code_subdir/
    - ...
```

Then wrap the widget from that source file by a `WidgetWithCodeView`:

```dart
WidgetWithCodeView(
  child: MyAwesomeWidget(), // ⚡️ If null, will only show the source code view.
  filePath: 'lib/my_awesome_source_code.dart',
  /// [codeLinkPrefix] is optional. When it's specified, two more buttons
  /// (open-code-in-browser, copy-code-link) will be added in the code view.
  codeLinkPrefix: 'https://github.com/<my_username>/<my_project>/blob/master/',
),
```

You can also choose to only show the code by not setting the `child` argument.

See `example/lib/main.dart` for a concrete example.
