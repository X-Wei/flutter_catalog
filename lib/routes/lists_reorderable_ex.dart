import 'package:flutter/material.dart';
import '../my_route.dart';

class ReorderableListExample extends MyRoute {
  const ReorderableListExample(
      [String sourceFile = 'lib/routes/lists_reorderable_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Reorderable list';

  @override
  get links => {
        'Doc':
            'https://docs.flutter.io/flutter/material/ReorderableListView-class.html'
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _ReorderableListDemo();
  }
}

// Adapted from reorderable list demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/reorderable_list_demo.dart
class _ReorderableListDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return __ReorderableListDemoState();
  }
}

class _ListItem {
  _ListItem(this.value, this.checked);
  final String value;
  bool checked;
}

class __ReorderableListDemoState extends State<_ReorderableListDemo> {
  bool _reverseSort = false;
  static final _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
  ].map((item) => _ListItem(item, false)).toList();

  // Handler called by ReorderableListView onReorder after a list child is
  // dropped into a new position.
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _ListItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  // Handler called when the "sort" button on appbar is clicked.
  void _onSort() {
    setState(() {
      _reverseSort = !_reverseSort;
      _items.sort((_ListItem a, _ListItem b) => _reverseSort
          ? b.value.compareTo(a.value)
          : a.value.compareTo(b.value));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _appbar = AppBar(
      title: Text('Reorderable list'),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.sort_by_alpha),
          tooltip: 'Sort',
          onPressed: _onSort,
        ),
      ],
    );
    final _listTiles = _items
        .map(
          (item) => CheckboxListTile(
                key: Key(item.value),
                value: item.checked ?? false,
                onChanged: (bool newValue) {
                  setState(() => item.checked = newValue);
                },
                title: Text('This item represents ${item.value}.'),
                isThreeLine: true,
                subtitle: Text('Item ${item.value}, checked=${item.checked}'),
                secondary: Icon(Icons.drag_handle),
              ),
        )
        .toList();
    return Scaffold(
      appBar: _appbar,
      body: ReorderableListView(
        onReorder: _onReorder,
        children: _listTiles,
      ),
    );
  }
}
