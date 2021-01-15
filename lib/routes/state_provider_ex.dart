import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderExample extends StatelessWidget {
  const ProviderExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // This is a stream that shows how many seconds have elapsed.
        StreamProvider<int>(
          initialData: 0,
          create: (BuildContext context) =>
              Stream.periodic(const Duration(milliseconds: 1000), (i) => i),
        ),
        ChangeNotifierProvider<_MyCounterState>(
          create: (_) => _MyCounterState(),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _MyDemoApp(),
      ),
    );
  }
}

// ###1. Define a state class, extending from ChangeNotifier.
class _MyCounterState extends ChangeNotifier {
  int _counter = 0;

  int get counterValue => _counter;

  void incrementCounter() {
    _counter++;
    // Must add notifyListeners() when UI need to be changed.
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }
}

class _MyDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Text(
            "Provider is the officially recommended way to manage app states, "
            "it's quite similar to ScopedModel in sharing/updating of app's "
            "state from children widgets down the widgets tree. In addition, "
            "you can provider multiple states at app root.\n\n"
            "In this example, the app's root widget is a MultiProvider, which "
            "provides two states: the number of seconds elapsed (StreamProvider) "
            "and the counter value(ChangeNotifierProvider).\n\n"
            "There's a text widget showing the seconds elapsed, and two card "
            "widgets showing the counter value. Clicking on child widget's "
            "button would update the _MyCounterState of the app.\n"),
        _AppRootWidget(),
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
          Text('${Provider.of<int>(context)} seconds elapsed'),
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
    // Way 1 to get state up the tree: `Provider.of<T>()`.
    // Note: since v4.1, we can use extension methods which is nicer:
    //   - context.watch<T>() -- equivalent to Provider.of<T>()
    //   - context.read<T>()  -- equivalent to Provider.of<T>(listen: false)
    final state = Provider.of<_MyCounterState>(context, listen: false);
    return Card(
      margin: const EdgeInsets.all(4.0).copyWith(top: 32.0, bottom: 32.0),
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          const Text('(child widget)'),
          Text(
            '${state.counterValue}',
            style: Theme.of(context).textTheme.headline4,
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => state.incrementCounter(),
              ),
              // Way 2 to get state up the tree: wrap a Consumer widget.
              Consumer<_MyCounterState>(
                builder: (BuildContext context, _MyCounterState value,
                    Widget child) {
                  return IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => value.decrementCounter(),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
