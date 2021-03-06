import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:syntax_highlighter/syntax_highlighter.dart'
    show SyntaxHighlighterStyle, DartSyntaxHighlighter;
import 'package:url_launcher/url_launcher.dart';

const String _markdownSrc = '''
# Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted
 Dart code in your app.

## Styling
Style text as _italic_, __bold__, or `inline code`.
- Use bulleted lists
- To better clarify
- Your points

## Links
You can use [hyperlinks](https://flutter.dev) in markdown

## Images
You can include images:
![Flutter logo](https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png)

## Markdown widget
This is an example of how to create your own Markdown widget:

`new Markdown(data: 'Hello _world_!');`


## Code blocks
Formatted Dart code looks really pretty too:
```dart
void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new Markdown(data: markdownData)
    )
  ));
}
```

## Tables: 

| foo | bar |
| --- | --- |
| baz | bim |

Enjoy!
''';

class MarkdownExample extends StatelessWidget {
  const MarkdownExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _onTapLink(String text, String href, String title) async {
      if (await canLaunch(href)) {
        launch(href);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong address: $href'),
          ),
        );
      }
    }

    return Scrollbar(
      child: Markdown(
        data: _markdownSrc,
        onTapLink: _onTapLink,
        selectable: true,
        syntaxHighlighter: _MyDartSyntaxHighligher(),
        //// We use [GitHub flavored Markdown]: https://github.github.com/gfm/.
        extensionSet: md.ExtensionSet(
          /*blockSyntaxes=*/ md.ExtensionSet.gitHubFlavored.blockSyntaxes,
          /*inlineSyntaxes=*/ md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
        ),
      ),
    );
  }
}

/// Note: There is a package [syntax_highlighter] with [format] function, but
/// (at version=0.1.1) it doesn't extend the [flutter_markdown.SyntaxHighlighter]
/// class, thus cannot be used in [Markdown]. So here we add a custom wrapper.
/// TODO: create a pull request to the [syntax_highlighter] package.
class _MyDartSyntaxHighligher extends SyntaxHighlighter {
  final highlighter =
      DartSyntaxHighlighter(SyntaxHighlighterStyle.lightThemeStyle());
  @override
  TextSpan format(String source) {
    return TextSpan(
      style: GoogleFonts.droidSansMono(),
      children: <TextSpan>[highlighter.format(source)],
    );
  }
}
