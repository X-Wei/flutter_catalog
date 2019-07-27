import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key key}) : super(key: key);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
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
          // **Note**: if got "ERR_CLEARTEXT_NOT_PERMITTED", modify
          // AndroidManifest.xml.
          // Cf. https://github.com/flutter/flutter/issues/30368#issuecomment-480300618
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
