import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late TextEditingController _controller;
  late WebViewController _webviewController;

  @override
  void initState() {
    super.initState();
    this._controller = TextEditingController();
    this._webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = 'www.google.com';
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        TextField(
          controller: this._controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter URL to open it in webview.',
            labelText: 'URL to open',
          ),
        ),
        ButtonBar(
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open in webview'),
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

  Future<void> _openInWebview(String url) async {
    final canLaunch = await url_launcher.canLaunchUrl(Uri.parse(url));
    if (!mounted) return;
    if (canLaunch) {
      Navigator.of(context).push(
        MaterialPageRoute(
          // **Note**: if got "ERR_CLEARTEXT_NOT_PERMITTED", modify
          // AndroidManifest.xml.
          // Cf. https://github.com/flutter/flutter/issues/30368#issuecomment-480300618
          builder: (ctx) => Scaffold(
            appBar: AppBar(title: Text(url)),
            body: WebViewWidget(
                controller: _webviewController..loadRequest(Uri.parse(url))),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('URL $url can not be launched.'),
        ),
      );
    }
  }
}
