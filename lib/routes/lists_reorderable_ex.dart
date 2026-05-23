import 'package:flutter/material.dart';

// Adapted from reorderable list demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/reorderable_list_demo.dart
class ReorderableListExample extends StatefulWidget {
  const ReorderableListExample({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReorderableListExampleState();
  }
}

class _ReorderableListExampleState extends State<ReorderableListExample> {
  bool _reverseSort = false;
  final List<String> _items = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').toList();

  // Handler called by ReorderableListView onReorderItem after a list child is
  // dropped into a new position. Unlike the deprecated onReorder, newIndex is
  // already adjusted for the removal of the item at oldIndex.
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  // Handler called when the "sort" button on appbar is clicked.
  void _onSort() {
    setState(() {
      _reverseSort = !_reverseSort;
      _items.sort((a, b) => _reverseSort ? b.compareTo(a) : a.compareTo(b));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: const Text('Reorderable list'),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.sort_by_alpha),
          tooltip: 'Sort',
          onPressed: _onSort,
        ),
      ],
    );
    return Scaffold(
      appBar: _appbar,
      body: ReorderableListView(
        onReorderItem: _onReorder,
        children: [
          for (final item in _items)
            ListTile(
              /// ! Must provide unique Keys for ReorderableListView's children.
              key: Key(item),
              title: Text('item $item'),
            ),
        ],
      ),
    );
  }
}
