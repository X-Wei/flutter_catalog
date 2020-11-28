import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Adapted from Eajy's flutter demo app:
// https://github.com/Eajy/flutter_demo/blob/master/lib/route/homeDialogs.dart.
class DialogsExample extends StatelessWidget {
  const DialogsExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32.0),
      children: <Widget>[
        ////// Alert dialog.
        RaisedButton(
          color: Colors.red,
          onPressed: () {
            // The function showDialog<T> returns Future<T>.
            // Use Navigator.pop() to return value (of type T).
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Dialog title'),
                content: const Text(
                  'Sample alert',
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ).then((returnVal) {
              if (returnVal != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You clicked: $returnVal'),
                    action: SnackBarAction(label: 'OK', onPressed: () {}),
                  ),
                );
              }
            });
          },
          child: const Text('Alert Dialog'),
        ),
        ////// Simple Dialog.
        RaisedButton(
          color: Colors.yellow,
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                title: const Text('Dialog Title'),
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('user@example.com'),
                    onTap: () => Navigator.pop(context, 'user@example.com'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('user2@gmail.com'),
                    onTap: () => Navigator.pop(context, 'user2@gmail.com'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_circle),
                    title: const Text('Add account'),
                    onTap: () => Navigator.pop(context, 'Add account'),
                  ),
                ],
              ),
            ).then((returnVal) {
              if (returnVal != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You clicked: $returnVal'),
                    action: SnackBarAction(label: 'OK', onPressed: () {}),
                  ),
                );
              }
            });
          },
          child: const Text('Simple dialog'),
        ),
        ////// Time Picker Dialog.
        RaisedButton(
          color: Colors.green,
          onPressed: () {
            final DateTime now = DateTime.now();
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
            ).then((TimeOfDay value) {
              if (value != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value.format(context)),
                    action: SnackBarAction(label: 'OK', onPressed: () {}),
                  ),
                );
              }
            });
          },
          child: const Text('Time Picker Dialog'),
        ),
        ////// Date Picker Dialog.
        RaisedButton(
          color: Colors.blue,
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2025),
            ).then((DateTime value) {
              if (value != null) {
                DateTime _fromDate = DateTime.now();
                _fromDate = value;
                final String date = DateFormat.yMMMd().format(_fromDate);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected date: $date')),
                );
              }
            });
          },
          child: const Text('Date Picker Dialog'),
        ),
        ////// Bottom Sheet Dialog.
        RaisedButton(
          color: Colors.orange,
          onPressed: () {
            // Or: showModalBottomSheet(), with model bottom sheet, clicking
            // anywhere will dismiss the bottom sheet.
            showBottomSheet<String>(
              context: context,
              builder: (BuildContext context) => Container(
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    const ListTile(
                      dense: true,
                      title: Text('This is a bottom sheet'),
                    ),
                    const ListTile(
                      dense: true,
                      title: Text('Click OK to dismiss'),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Text('Bottom Sheet'),
        ),
      ]
          .map(
            (Widget button) => Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: button,
            ),
          )
          .toList(),
    );
  }
}
