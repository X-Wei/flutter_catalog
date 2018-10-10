import 'package:flutter/material.dart';
import '../my_route.dart';

// Adapted from Tensor Programming's multi-page app tutorial:
// https://github.com/tensor-programming/dart_flutter_multi_page_app.
class DialogsExample extends MyRoute {
  const DialogsExample([String sourceFile = 'lib/routes/nav_dialogs_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Dialogs';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(32.0),
      children: <Widget>[
        ////// Simple alert dialog.
        RaisedButton(
            color: Colors.red,
            child: Text('Alert Dialog'),
            onPressed: () {
              // The function showDialog<T> returns Future<T>.
              // Use Navigator.pop() to return value (of type T).
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text('Dialog title'),
                      content: Text(
                        'Sample alert',
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                        ),
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context, 'OK'),
                        ),
                      ],
                    ),
              ).then<String>((returnVal) {
                if (returnVal != null) {
                  Scaffold.of(context)
                    ..showSnackBar(
                      SnackBar(content: Text('You clicked: $returnVal')),
                    );
                }
              });
            }),
        ////// Time Picker Dialog.
        RaisedButton(
          color: Colors.green,
          child: Text('Time Picker Dialog'),
          onPressed: () {
            DateTime now = DateTime.now();
            showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
            ).then<TimeOfDay>((TimeOfDay value) {
              if (value != null) {
                Scaffold.of(context)
                  ..showSnackBar(
                    SnackBar(content: Text('${value.format(context)}')),
                  );
              }
            });
          },
        ),
        ////// Date Picker Dialog.
        RaisedButton(
          color: Colors.blue,
          child: Text('Date Picker Dialog'),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2019),
            ).then<DateTime>((DateTime value) {
              if (value != null) {
                Scaffold.of(context)
                  ..showSnackBar(
                    SnackBar(content: Text('Selected datetime: $value')),
                  );
              }
            });
          },
        ),
        ////// Bottom Sheet Dialog.
        RaisedButton(
          color: Colors.orange,
          child: Text('Bottom Sheet'),
          onPressed: () {
            // Or: showModalBottomSheet(), with model bottom sheet, clicking
            // anywhere will dismiss the bottom sheet.
            showBottomSheet<String>(
              context: context,
              builder: (BuildContext context) => Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12)),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          title: Text('This is a bottom sheet'),
                        ),
                        ListTile(
                          dense: true,
                          title: Text('Click OK to dismiss'),
                        ),
                        ButtonTheme.bar(
                          // make buttons use the appropriate styles for cards
                          child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            );
          },
        ),
      ],
    );
  }
}
