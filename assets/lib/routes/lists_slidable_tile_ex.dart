import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableTileExample extends StatefulWidget {
  const SlidableTileExample({super.key});

  @override
  _SlidableTileExampleState createState() => _SlidableTileExampleState();
}

class _SlidableTileExampleState extends State<SlidableTileExample> {
  static final _kActionpaneTypes = <String, Widget>{
    'DrawerMotion': DrawerMotion(),
    'BehindMotion': BehindMotion(),
    'ScrollMotion': ScrollMotion(),
    'StretchMotion': StretchMotion(),
  };
  late List<Slidable> _items;
  @override
  void initState() {
    super.initState();
    final mainActions = <Widget>[
      SlidableAction(
        label: 'Archive',
        foregroundColor: Colors.blue,
        icon: Icons.archive,
        onPressed: (_) => _showSnackBar('Archive'),
      ),
      SlidableAction(
        label: 'Share',
        foregroundColor: Colors.indigo,
        icon: Icons.share,
        onPressed: (_) => _showSnackBar('Share'),
        // Don't automatically close.
        autoClose: false,
      ),
    ];
    final secondaryActions = <Widget>[
      SlidableAction(
        label: 'More',
        foregroundColor: Colors.black45,
        icon: Icons.more_horiz,
        onPressed: (_) => _showSnackBar('More'),
      ),
      SlidableAction(
        label: 'Delete',
        foregroundColor: Colors.red,
        icon: Icons.delete,
        onPressed: (_) => _showSnackBar('Delete'),
      ),
    ];
    _items = [
      for (final entry in _kActionpaneTypes.entries)
        Slidable(
          key: ValueKey(entry.key),
          // swipe right
          startActionPane: ActionPane(
            motion: entry.value,
            extentRatio: 0.2,
            children: mainActions,
          ),
          //swipe left
          endActionPane: ActionPane(
            motion: entry.value,
            extentRatio: 0.2,
            children: secondaryActions,
          ),
          child: ListTile(
            leading: const Icon(Icons.swipe),
            title: Text('ListTile with ${entry.key}'),
            subtitle: const Text('Swipe left and right to see the actions'),
          ),
        ),
    ];
    // Dismissible tile example:
    // First create a dismissal obj
    final dismissal = DismissiblePane(
      onDismissed: () {
        _showSnackBar('Dismiss Archive');
        setState(() => this._items.removeAt(_items.length - 1));
      },
      // Confirm on dismissal:
      confirmDismiss: () async {
        final bool? ret = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Archive'),
              content: const Text('Confirm action?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
        return ret ?? false;
      },
    );
    // Set the `dismissal` argument to ActionPane.
    _items.add(
      Slidable(
        key: const Key('dimissibleTile'),
        startActionPane: ActionPane(
          motion: DrawerMotion(),
          dismissible: dismissal,
          children: [mainActions[0]], // 'Archive' action
        ),
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [secondaryActions[1]], // 'Delete' action
        ),
        child: const ListTile(
          leading: Icon(Icons.swap_horiz),
          title: Text('Dismissible tile'),
          subtitle: Text('Swipe right to archieve, swipe left to delete'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _items);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
