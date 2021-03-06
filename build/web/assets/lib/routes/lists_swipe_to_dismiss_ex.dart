import 'package:flutter/material.dart';

class ListSwipeToDismissExample extends StatefulWidget {
  const ListSwipeToDismissExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListSwipeToDismissExampleState();
  }
}

class _ListSwipeToDismissExampleState extends State<ListSwipeToDismissExample> {
  final _items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final String item = _items[index];
        // Each Dismissible must contain a Key. Keys allow Flutter to uniquely
        // identify Widgets.
        return Dismissible(
          key: Key(item),
          // We also need to provide a function that tells our app what to do
          // after an item has been swiped away.
          onDismissed: (DismissDirection dir) {
            setState(() => this._items.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(dir == DismissDirection.startToEnd
                    ? '$item removed.'
                    : '$item liked.'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    setState(() => this._items.insert(index, item));
                  },
                ),
              ),
            );
          },
          // Show a red background as the item is swiped away
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: const Icon(Icons.delete),
          ),
          // Background when swipping from right to left
          secondaryBackground: Container(
            color: Colors.green,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.thumb_up),
          ),
          child: ListTile(
            title: Center(child: Text(_items[index])),
          ),
        );
      },
    );
  }
}
