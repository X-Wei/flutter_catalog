import 'package:flutter/material.dart';
import '../my_route.dart';

class InheritedWidgetExample extends MyRoute {
  const InheritedWidgetExample(
      [String sourceFile = 'lib/routes/state_inherited_widget_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'InheritedWidget';

  @override
  get description => 'Access state of widgets up the tree.';

  @override
  get links => {
        'Doc':
            'https://docs.flutter.io/flutter/widgets/InheritedWidget-class.html',
        'Youtube': 'https://www.youtube.com/watch?v=4I68ilX0Y24',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return InheritedWidgetDemo();
  }
}

class InheritedWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyDemo(),
    );
  }
}

// ###1. Define an InheritedWidget that stores `MyDemoState` (c.f. the
// 'MyDemo' StatefulWidget  that we defined below).
// All descendants of this widget can access `myState` by:
// final stateOfParent = MyInheritedWidget.of(context).myState;
// NOTE: InheritedWidget are *stateless*.
class MyInheritedWidget extends InheritedWidget {
  final MyDemoState myState;

  MyInheritedWidget({Key key, Widget child, @required this.myState})
      : super(key: key, child: child);

  @override
  // Returns when it's children widget should be notified for rebuild.
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return this.myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyInheritedWidget);
  }
}

// ###2. Define a stateFUL widget where the corresponding State<MyDemo> is to be
// fetched by children widgets.
class MyDemo extends StatefulWidget {
  @override
  MyDemoState createState() => MyDemoState();
}

class MyDemoState extends State<MyDemo> {
  // In this demo the state is just _counter.
  int _counter = 0;

  int get counterValue => _counter;

  // Note: these state-mutating functions must be wrapped by setState.
  void incrementCounter() => setState(() => _counter++);
  void decrementCounter() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
    // ###3. Put the inherited widget at the root of the widget tree, so that
    // all children widgets can access the state.
    return MyInheritedWidget(
      myState: this,
      child: ListView(
        children: <Widget>[
          Text("InheritedWidget allows efficient sharing of app's state down "
              "the widgets tree.\n\n"
              "In this example, the app's root widget is an InheritedWidget, "
              "so it's state is shared to the two `CounterAndButtons` widgets "
              "below. \n\n"
              "Clicking on child widget's button would update the root "
              "widget's counter.\n\n"
              "Note: Recommend using ScopedModel for CHANGING parent's state "
              "from child widget*.\n"),
          _buildRootWidget(),
        ],
      ),
    );
  }

  Widget _buildRootWidget() {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Text('(root widget)'),
          Text(
            '${this.counterValue}',
            style: Theme.of(context).textTheme.display1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[CounterAndButton(), CounterAndButton()],
          ),
        ],
      ),
    );
  }
}

class CounterAndButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3. Retrieve parent widget's state.
    final rootWidgetsState = MyInheritedWidget.of(context).myState;
    return Card(
      margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
      color: Colors.white70,
      child: Column(
        children: <Widget>[
          Text('(child widget)'),
          Text(
            '${rootWidgetsState.counterValue}',
            style: Theme.of(context).textTheme.display1,
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => rootWidgetsState.incrementCounter(),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => rootWidgetsState.decrementCounter(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
