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
          const SnackBar(
            content: const Text('Button tapped'),
            duration: const Duration(milliseconds: 500),
          ),
        );
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            const Text('Raised buttons add dimension to mostly flat layouts. They '
                'emphasize functions on busy or wide spaces.'),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: _showSnack,
                  child: const Text('RaisedButton'),
                ),
                const RaisedButton(
                  onPressed: null,
                  child: const Text('disabled-RaisedButton'),
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        Column(
          children: <Widget>[
            const Text('A flat button displays an ink splash on press '
                'but does not lift. Use flat buttons on toolbars, in dialogs '
                'and inline with padding'),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: _showToast,
                  child: const Text('FlatButton'),
                ),
                const FlatButton(
                  onPressed: null,
                  child: const Text('disabled-FlatButton'),
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        Column(
          children: <Widget>[
            const Text('Outline buttons become opaque and elevate when pressed. They '
                'are often paired with raised buttons to indicate an '
                'alternative, secondary action.'),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlineButton(
                  onPressed: _showToast,
                  child: const Text('OutlineButton'),
                ),
                const OutlineButton(
                  onPressed: null,
                  child: const Text('OutlineButton'),
                )
              ],
            ),
          ],
        ),
        const Divider(),
        Column(
          children: <Widget>[
            const Text('Tooltips are short identifying messages that briefly appear '
                'in response to a long press. Tooltip messages are also used '
                'by services that make Flutter apps accessible, like screen '
                'readers.'),
            Center(
              child: IconButton(
                iconSize: 32.0,
                icon: const Icon(Icons.call),
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
