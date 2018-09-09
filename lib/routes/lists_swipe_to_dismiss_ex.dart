import 'package:flutter/material.dart';
import '../my_route.dart';

class ListSwipeToDismissExample extends MyRoute {
  const ListSwipeToDismissExample(
      [String sourceFile = 'lib/routes/lists_swipe_to_dismiss_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Swipe to dismiss';

  @override
  get links => {
        'Cookbook': 'https://flutter.io/cookbook/gestures/dismissible',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _SwipeToDismissList();
  }
}

class _SwipeToDismissList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwipeToDismissListState();
  }
}

class _SwipeToDismissListState extends State<_SwipeToDismissList> {
  final items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final String item = items[index];
        // Each Dismissible must contain a Key. Keys allow Flutter to
        // uniquely identify Widgets.
        return Dismissible(
          key: Key(item),
          // We also need to provide a function that tells our app
          // what to do after an item has been swiped away.
          onDismissed: (DismissDirection dir) {
            if (dir == DismissDirection.startToEnd) {
              setState(() {
                this.items.removeAt(index);
              });
            }
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(dir == DismissDirection.startToEnd
                  ? '$item dismissed.'
                  : '$item liked!'),
            ));
          },
          // Show a red background as the item is swiped away
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
            alignment: Alignment.centerLeft,
          ),
          // Background when swipping from right to left
          secondaryBackground: Container(
            color: Colors.green,
            child: Icon(Icons.thumb_up),
            alignment: Alignment.centerRight,
          ),
          child: ListTile(
            title: Center(child: Text('${items[index]}')),
          ),
        );
      },
    );
  }
}
