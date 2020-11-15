import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocLibExample extends StatelessWidget {
  const BlocLibExample({Key key}) : super(key: key);

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
// would be such a state. Note the state must be IMMUTABLE in flutter_bloc from
// v0.6.0. Instead of mutating the state, create a new state instance.
class _MyState {
  final int counter;

  const _MyState(this.counter);
}

// ###3. Define a MyBloc class which extends Bloc<_MyEvent, _MyState> from the
// flutter_bloc package. With this package, we don't need to manage the stream
// controllers.
class MyBloc extends Bloc<_MyEvent, _MyState> {
  MyBloc(_MyState initialState) : super(initialState);

  // The business logic is in this mapEventToState function.
  // Note: in flutter_bloc from v0.6.0 on, states are enforced IMMUTABLE,
  // mutating state and yielding the it won't update on UI.
  // C.f. https://github.com/felangel/bloc/issues/103.
  @override
  Stream<_MyState> mapEventToState(_MyEvent event) async* {
    _MyState newState;
    if (event.isIncrement) {
      newState = _MyState(state.counter + 1);
    } else {
      newState = _MyState(state.counter - 1);
    }
    yield newState;
  }

  // Instead of doing bloc.sink.add(), we do bloc.add().
  void increment() => this.add(_MyEvent(isIncrement: true));
  void decrement() => this.add(_MyEvent(isIncrement: false));
}

class _MyDemoApp extends StatefulWidget {
  @override
  _MyDemoAppState createState() {
    return _MyDemoAppState();
  }
}

class _MyDemoAppState extends State<_MyDemoApp> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Text(
            "BLoC pattern is great for accessing/mutating app's state and "
            "updating UI without rebuilding the whole widget tree. But the vanilla "
            "BLoC implementation has too much boilerplate code. \n\n"
            "With the flutter_bloc package, we don't need to manage Streams "
            "or implement our own BlocProvider/InheritedWidget. We only need to "
            "implement the core business logic in the `mapEventToState` function.\n"),
        // ###4. Use the BlocProvider from flutter_bloc package, we don't need
        // to write our own InheritedWidget.
        BlocProvider<MyBloc>(
          create: (BuildContext context) => MyBloc(const _MyState(0)),
          child: _AppRootWidget(),
        ),
      ],
    );
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
    return Card(
      margin: const EdgeInsets.all(4.0).copyWith(top: 32.0, bottom: 32.0),
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          const Text('(child widget)'),
          // ###5. Access the state from child widget by wrapping the widget by
          // a BlocBuilder.
          BlocBuilder(
            cubit: BlocProvider.of<MyBloc>(context),
            builder: (context, _MyState state) {
              return Text(
                '${state.counter}',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                // ###6. Post new event by calling functions in bloc or by
                // bloc.add(newEvent);
                onPressed: () => BlocProvider.of<MyBloc>(context).increment(),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => BlocProvider.of<MyBloc>(context).decrement(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
