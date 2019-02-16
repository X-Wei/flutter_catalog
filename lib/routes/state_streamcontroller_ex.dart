import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as english_words;
import '../my_route.dart';

class StreamControllerExample extends MyRoute {
  const StreamControllerExample(
      [String sourceFile = 'lib/routes/state_streamcontroller_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'StreamController';

  @override
  get description =>
      'Receive data from sink and output at stream, two StreamControllers can make a "Bloc".';

  @override
  get links => {
        'Doc':
            'https://api.dartlang.org/stable/2.1.1/dart-async/StreamController-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: _StreamControllerDemo(),
    );
  }
}

class _StreamControllerDemo extends StatefulWidget {
  @override
  _StreamControllerDemoState createState() {
    return new _StreamControllerDemoState();
  }
}

// The data class in our demo stream, contains just a message string and a
// timestamp.
class _Data {
  final String message;
  final DateTime timestamp;

  _Data({@required this.message, @required this.timestamp});
}

class _StreamControllerDemoState extends State<_StreamControllerDemo> {
  // The app puts value to _inputStreamController.sink, and renders widget from
  // _outputStreamController.stream.
  final _inputStreamController = StreamController<_Data>();
  final _outputStreamController = StreamController<Widget>();

  @override
  void initState() {
    super.initState();
    // This function connects the input and output stream controller, and does
    // the transformation (business logic) in between.
    void _onData(_Data data) {
      final widgetToRender = ListTile(
        title: Text(data.message),
        subtitle: Text(data.timestamp.toString()),
      );
      _outputStreamController.sink.add(widgetToRender);
    }

    _inputStreamController.stream.listen(_onData);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("StreamController is like a pipe with `sink` as input and `stream`"
            "as output. \n\n"
            "To put a new value to the stream, use `streamController.sink.add(newValue)`; "
            "to access the output stream, use `streamController.stream`.\n\n"
            "Note: we can't transform the stream's value inside the controller, "
            "the output is exactly the input. Instead, we can use two stream controllers, "
            "and put a function between the input controller and output controller.\n\n"
            "In this demo, the card renders the widget from _outputStreamController.stream"
            "and you can send a new random word to the "
            "_inputStreamController.sink by clicking the 'send' button.\n"),
        Card(
          elevation: 4.0,
          child: StreamBuilder<Widget>(
            stream: _outputStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return ListTile(
                  leading: CircularProgressIndicator(),
                  title: Text('no data'),
                );
              }
              final Widget widgetToRender = snapshot.data;
              return widgetToRender;
            },
          ),
        ),
        RaisedButton.icon(
          icon: Icon(Icons.send),
          label: Text('Send random word to input stream'),
          onPressed: () => this._inputStreamController.sink.add(
                _Data(
                  message: english_words.WordPair.random().asPascalCase,
                  timestamp: DateTime.now(),
                ),
              ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // Note: must explicitly close the stream controllers to release resource!
    this._inputStreamController.close();
    this._outputStreamController.close();
    super.dispose();
  }
}
