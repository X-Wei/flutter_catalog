import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ExtendedImageExample extends StatefulWidget {
  const ExtendedImageExample({Key key}) : super(key: key);

  @override
  _ExtendedImageExampleState createState() => _ExtendedImageExampleState();
}

class _ExtendedImageExampleState extends State<ExtendedImageExample> {
  final GlobalKey<ExtendedImageEditorState> _editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedImage.asset(
        'res/images/dart-side.png',
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        extendedImageEditorKey: _editorKey,
        initEditorConfigHandler: (state) {
          return EditorConfig(
            maxScale: 8.0,
            cropRectPadding: EdgeInsets.all(20.0),
            hitTestSize: 20.0,
            // cropAspectRatio: _aspectRatio.aspectRatio,
          );
        },
      ),
      bottomNavigationBar: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ButtonBar(
          children: <Widget>[
            RaisedButton.icon(
              label: Text('Rotate right'),
              icon: Icon(Icons.rotate_right),
              onPressed: () => _editorKey.currentState.rotate(right: true),
            ),
            RaisedButton.icon(
              label: Text('Rotate left'),
              icon: Icon(Icons.rotate_left),
              onPressed: () => _editorKey.currentState.rotate(right: false),
            ),
            RaisedButton.icon(
              label: Text('Reset'),
              icon: Icon(Icons.restore),
              onPressed: () => _editorKey.currentState.reset(),
            ),
          ],
        ),
      ),
    );
  }
}
