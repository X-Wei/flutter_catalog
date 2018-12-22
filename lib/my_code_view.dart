import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './syntax_highlighter.dart';

class MyCodeView extends StatefulWidget {
  final String filePath;

  MyCodeView({@required this.filePath});

  @override
  MyCodeViewState createState() {
    return new MyCodeViewState();
  }
}

class MyCodeViewState extends State<MyCodeView> {
  double _textScaleFactor = 1.0;

  Widget _getCodeView(String codeContent, BuildContext context) {
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    // TODO: try out CustomScrollView and SliverAppbar (appbar auto hides when scroll).
    return Scrollbar(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: GestureDetector(
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() => this._textScaleFactor = details.scale);
              },
              child: RichText(
                  textScaleFactor: this._textScaleFactor,
                  text: TextSpan(
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
                      children: <TextSpan>[
                        DartSyntaxHighlighter(style).format(codeContent)
                      ])),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Loading string from file returns a Future<String>, so instead of returning directly the
    // widget, we need a FutureBuilder.
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(widget.filePath) ??
          'Error loading source code from $this.filePath',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return _getCodeView(snapshot.data, context);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
