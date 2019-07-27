import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonsExample extends StatelessWidget {
  const ButtonsExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showToast = () => Fluttertoast.showToast(
          msg: 'Button tapped',
          toastLength: Toast.LENGTH_SHORT,
        );

    final _showSnack = () => Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Button tapped'),
            duration: Duration(milliseconds: 500),
          ),
        );
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('Raised buttons add dimension to mostly flat layouts. They '
                'emphasize functions on busy or wide spaces.'),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('RaisedButton'),
                  onPressed: _showSnack,
                ),
                RaisedButton(
                  child: Text('disabled-RaisedButton'),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
        Divider(),
        Column(
          children: <Widget>[
            Text('A flat button displays an ink splash on press '
                'but does not lift. Use flat buttons on toolbars, in dialogs '
                'and inline with padding'),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text('FlatButton'),
                  onPressed: _showToast,
                ),
                FlatButton(
                  child: Text('disabled-FlatButton'),
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
        Divider(),
        Column(
          children: <Widget>[
            Text('Outline buttons become opaque and elevate when pressed. They '
                'are often paired with raised buttons to indicate an '
                'alternative, secondary action.'),
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
        Divider(),
        Column(
          children: <Widget>[
            Text('Tooltips are short identifying messages that briefly appear '
                'in response to a long press. Tooltip messages are also used '
                'by services that make Flutter apps accessible, like screen '
                'readers.'),
            Center(
              child: IconButton(
                iconSize: 32.0,
                icon: Icon(Icons.call),
                tooltip: 'Place a phone call',
                onPressed: _showSnack,
              ),
            )
          ],
        ),
      ],
    );
  }
}
