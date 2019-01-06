import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_route.dart';

const String _markdownData = '''
# Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted
 Dart code in your app.
## Styling
Style text as _italic_, __bold__, or `inline code`.
- Use bulleted lists
- To better clarify
- Your points
## Links
You can use [hyperlinks](https://flutter.io) in markdown
## Images
You can include images:
![Flutter logo](https://flutter.io/images/flutter-mark-square-100.png#100x100)
## Markdown widget
This is an example of how to create your own Markdown widget:
    new Markdown(data: 'Hello _world_!');
## Code blocks
Formatted Dart code looks really pretty too:
```
void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new Markdown(data: markdownData)
    )
  ));
}
```
Enjoy!
''';

class MarkdownExample extends MyRoute {
  const MarkdownExample(
      [String sourceFile = 'lib/routes/plugins_markdown_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Markdown rendering';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    void _onTapLink(href) async {
      if (await canLaunch(href)) {
        launch(href);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Wrong address: $href'),
          ),
        );
      }
    }

    return Scrollbar(
      child: Markdown(
        data: _markdownData,
        onTapLink: _onTapLink,
      ),
    );
  }
}
