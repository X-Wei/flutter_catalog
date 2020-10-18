import 'dart:async';
import 'package:flutter/material.dart';

class BlocExample extends StatelessWidget {
  const BlocExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _MyDemoApp(),
    );
  }
}

// ###1. Define an Event class that represents an event in our app. The widgets
// pass _MyEvent objects as inputs to MyBloc.
class _MyEvent {
  final bool isIncrement;
  final DateTime timestamp;

  _MyEvent({@required this.isIncrement, DateTime timestamp})
      : this.timestamp = timestamp ?? DateTime.now();
}

// ###2. Define a State class that represents our app's state. MyBloc's output
// would be such a state.
class _MyState {
  int _counter = 0;

  int get counterValue => _counter;
  void incrementCounter() => _counter++;
  void decrementCounter() => _counter--;
}

// ###3. Define a Bloc class with input events sink and output state stream.
class MyBloc {
  final _MyState _state = _MyState();
  final _inputEventStreamController = StreamController<_MyEvent>();
  // Note: mus use the .broadcast() constructor: we expect the output stream to
  // be listened in more than one place.
  final _outputStateStreamController = StreamController<_MyState>.broadcast();

  // The input and output of MyBloc:
  StreamSink<_MyEvent> get inputSink => _inputEventStreamController.sink;
  Stream<_MyState> get outputStream => _outputStateStreamController.stream;

  MyBloc() {
    // This function connects the input and output stream controller, and does
    // the transformation (business logic) in between.
    void onEvent(_MyEvent event) {
      if (event.isIncrement) {
        _state.incrementCounter();
      } else {
        _state.decrementCounter();
      }
      _outputStateStreamController.sink.add(_state);
    }

    _inputEventStreamController.stream.listen(onEvent);
  }

  // Remember to close the stream controllers to avoid memory leak!!
  void dispose() {
    _inputEventStreamController.close();
    _outputStateStreamController.close();
  }
}

// ###4. Define a MyBlocProvider class which is an InheritedWidget.
class MyBlocProvider extends InheritedWidget {
  final MyBloc bloc;
  @override
  final Widget child; // ignore: overridden_fields

  const MyBlocProvider({Key key, @required this.bloc, this.child})
      : super(key: key, child: child);

  static MyBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyBlocProvider>();
  }

  @override
  bool updateShouldNotify(MyBlocProvider oldWidget) => true;
}

class _MyDemoApp extends StatefulWidget {
  @override
  _MyDemoAppState createState() {
    return _MyDemoAppState();
  }
}

class _MyDemoAppState extends State<_MyDemoApp> {
  final _bloc = MyBloc();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Text(
            "BLoC pattern is a combination of StreamBuilder and InheritedWidget. "
            "Using StreamBuilder allows extracting all business logic into a "
            "separate 'MyBloc' class; using a InheritedWidget (usually name it "
            "as 'MyBlocProviders') allows accessing myBloc from children widgets "
            "down the widgets tree.\n\n"
            "In this example, the app's root widget is a MyBlocProvider (InheritedWidget), "
            "so MyBlocProvider.myBloc is accessed by the two 'CounterAndButtons' children"
            " widgets below. \n\n"
            "Clicking on one child widget's button would update the app's "
            "state of root widget.\n"),
        // ###5. Put MyBlocProvider as the app's root widget, so children widget can
        // access the bloc.
        MyBlocProvider(
          bloc: this._bloc,
          child: _AppRootWidget(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    this._bloc.dispose();
    super.dispose();
  }
}

class _AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          const Text('(root widget)'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _CounterAndButton(),
              _CounterAndButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterAndButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyBloc bloc = MyBlocProvider.of(context).bloc;
    return Card(
      margin: const EdgeInsets.all(4.0).copyWith(top: 32.0, bottom: 32.0),
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          const Text('(child widget)'),
          // ###6. Access the state from child widget by wrapping the widget by
          // a StreamBuilder.
          StreamBuilder<_MyState>(
            stream: bloc.outputStream,
            builder: (context, AsyncSnapshot<_MyState> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              print(snapshot.data);
              final state = snapshot.data;
              return Text(
                '${state.counterValue}',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                // ###7. Post new event to MyBloc by adding to bloc.inputSink.
                onPressed: () =>
                    bloc.inputSink.add(_MyEvent(isIncrement: true)),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () =>
                    bloc.inputSink.add(_MyEvent(isIncrement: false)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
