import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './syntax_highlighter.dart';

class MyCodeView extends StatefulWidget {
  final String filePath;

  MyCodeView({@required this.filePath});

  @override
  MyCodeViewState createState() {
    return MyCodeViewState();
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
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: RichText(
                  textScaleFactor: this._textScaleFactor,
                  text: TextSpan(
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12.0),
                    children: <TextSpan>[
                      DartSyntaxHighlighter(style).format(codeContent)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.zoom_out),
              onPressed: () => setState(() {
                    this._textScaleFactor =
                        max(0.8, this._textScaleFactor - 0.1);
                  }),
            ),
            IconButton(
              icon: Icon(Icons.zoom_in),
              onPressed: () => setState(() {
                    this._textScaleFactor += 0.1;
                  }),
            ),
          ],
        ),
      ],
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
          return Padding(
            padding: EdgeInsets.all(4.0),
            child: _getCodeView(snapshot.data, context),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
