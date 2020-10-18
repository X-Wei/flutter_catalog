import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopedModelExample extends StatelessWidget {
  const ScopedModelExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _MyDemoApp(),
    );
  }
}

// ###1. Define a state class, extending from scoped_model.Model.
class _MyState extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void incrementCounter() {
    _counter++;
    // Must add notifyListeners() when UI need to be changed.
    // This will notify ALL it's descendants in the widget tree.
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
            "ScopedModel allows efficient sharing/updating of app's state from "
            "children widgets down the widgets tree.\n\n"
            "In this example, the app's root widget is a ScopedModel, "
            "so it's state is shared to the two 'CounterAndButtons' children"
            " widgets below. \n\n"
            "Clicking on child widget's button would update the MyStateModel "
            "of root widget.\n"),
        // ###2. Put the ScopedModel at the root of the widget tree, so that all
        // children widget can access the state.
        ScopedModel<_MyState>(
          model: _MyState(),
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
    // ###3. Wrap children widgets ScopedModelDescendant widget to access the
    // associated state model.
    return ScopedModelDescendant<_MyState>(
      // Note: Set `rebuildOnChange` to false if the current widget doesn't
      // need updating. E.g. When "add-to-cart" button is pressed, the app's
      // state is updated, but "product-details" page doesn't need updating.
      builder: (context, child, model) => Card(
        margin: const EdgeInsets.all(4.0).copyWith(top: 32.0, bottom: 32.0),
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            const Text('(child widget)'),
            Text(
              '${model.counterValue}',
              style: Theme.of(context).textTheme.headline4,
            ),
            ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => model.incrementCounter(),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => model.decrementCounter(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
