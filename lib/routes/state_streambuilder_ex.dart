import 'dart:async';
import 'package:flutter/material.dart';
import '../my_route.dart';

class StreamBuilderExample extends MyRoute {
  const StreamBuilderExample(
      [String sourceFile = 'lib/routes/state_streambuilder_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'StreamBuilder (timer app)';

  @override
  get description => 'Update UI according to the latest stream value.';

  @override
  get links => {
        'Doc':
            'https://docs.flutter.io/flutter/widgets/StreamBuilder-class.html',
        'Youtube': 'https://www.youtube.com/watch?v=MkKEWHfy99Y',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      child: StreamBuilderDemo(),
    );
  }
}

class StreamBuilderDemo extends StatefulWidget {
  @override
  StreamBuilderDemoState createState() {
    return new StreamBuilderDemoState();
  }
}

class StreamBuilderDemoState extends State<StreamBuilderDemo> {
  // The timer's value shown on app's UI.
  int _timerValue = 0;
  bool _paused = true;
  // A stream that updates every second. The stream's value is the number of
  // seconds elapsed since the app is started. We simply print this stream value
  // out in command-line. The value shown on UI is this._timerValue.
  final Stream<int> _periodicStream =
      Stream.periodic(Duration(milliseconds: 1000), (i) => i);
  // Record of the latest stream value that we saw. Because the StreamBuilder is
  // rebuilt when we call setState(), and in the re-build we shouldn't increment
  // this._timerValue if the latest snapshot's value hasn't changed.
  int _previousStreamValue = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._periodicStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != this._previousStreamValue) {
            print('Latest snapshot from stream: ${snapshot.data}');
            this._previousStreamValue = snapshot.data;
            if (!_paused) {
              this._timerValue++;
            }
          }
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("StreamBuilders can listen to a stream, and update UI "
                "according to the stream's latest snapshot value.\n\n"
                "In this demo we build a simple timer app by listening to a "
                "stream that updates every second.\n"),
            Card(child: _buildTimerUI()),
          ],
        );
      },
    );
  }

  Widget _buildTimerUI() {
    return Column(
      children: <Widget>[
        Text(
          '$_timerValue',
          style: Theme.of(context).textTheme.display1,
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: Icon(this._paused ? Icons.play_arrow : Icons.pause),
              onPressed: () => setState(() => this._paused = !this._paused),
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () => setState(
                    () {
                      this._timerValue = 0;
                      this._paused = true;
                    },
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
