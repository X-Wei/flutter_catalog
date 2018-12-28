import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import '../my_route.dart';

class WebViewExample extends MyRoute {
  const WebViewExample(
      [String sourceFile = 'lib/routes/plugins_webview_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Web View';

  @override
  get description => 'Open web page inside Flutter.';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _WebviewDemo(),
    );
  }
}

class _WebviewDemo extends StatefulWidget {
  @override
  _WebviewDemoState createState() => _WebviewDemoState();
}

class _WebviewDemoState extends State<_WebviewDemo> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = 'www.google.com';
    return Column(
      children: <Widget>[
        TextField(
          controller: this._controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter URL to open it in webview.',
            labelText: 'URL to open',
          ),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.open_in_new),
              label: Text('Open in webview'),
              onPressed: () {
                // Dismiss the keyboard, otherwise the webview will not take
                // full screen.
                // C.f. https://github.com/flutter/flutter/issues/7247#issuecomment-348269522
                FocusScope.of(context).requestFocus(FocusNode());
                this._openInWebview('http://${this._controller.text}');
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<Null> _openInWebview(String url) async {
    if (await url_launcher.canLaunch(url)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => WebviewScaffold(
                initialChild: Center(child: CircularProgressIndicator()),
                url: url,
                appBar: AppBar(title: Text(url)),
              ),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('URL $url can not be launched.'),
        ),
      );
    }
  }
}
