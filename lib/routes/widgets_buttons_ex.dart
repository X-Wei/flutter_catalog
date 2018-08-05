import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../my_route.dart';

class ButtonsExample extends MyRoute {
  const ButtonsExample(
      [String sourceFile = 'lib/routes/widgets_buttons_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Buttons';

  @override
  get description => 'RaisedButton, FlatButton, OutlineButton';

  @override
  get links => {
        'Doc': 'https://docs.flutter.io/flutter/material/ButtonBar-class.html',
        'Gallery button demo code':
            'https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/buttons_demo.dart'
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    final _showToast = () => Fluttertoast.showToast(
          msg: 'Button tapped',
          toastLength: Toast.LENGTH_SHORT,
        );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Raised buttons add dimension to mostly flat layouts. They '
                  'emphasize functions on busy or wide spaces.'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('RaisedButton'),
                  onPressed: _showToast,
                ),
                RaisedButton(
                  child: Text('disabled-RaisedButton'),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('A flat button displays an ink splash on press '
                  'but does not lift. Use flat buttons on toolbars, in dialogs '
                  'and inline with padding'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text('FlatButton'),
                  onPressed: _showToast,
                ),
                FlatButton(
                  child: Text('dsiabled-FlatButton'),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Outline buttons become opaque and elevate when pressed. They '
                  'are often paired with raised buttons to indicate an '
                  'alternative, secondary action.'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlineButton(
                  child: Text('OutlineButton'),
                  onPressed: _showToast,
                ),
                OutlineButton(
                  child: Text('OutlineButton'),
                  onPressed: null,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
