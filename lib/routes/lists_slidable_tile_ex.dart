import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableTileExample extends StatefulWidget {
  const SlidableTileExample({Key key}) : super(key: key);

  @override
  _SlidableTileExampleState createState() => _SlidableTileExampleState();
}

class _SlidableTileExampleState extends State<SlidableTileExample> {
  static const _kActionpaneTypes = <String, Widget>{
    'SlidableDrawerActionPane': SlidableDrawerActionPane(),
    'SlidableBehindActionPane': SlidableBehindActionPane(),
    'SlidableScrollActionPane': SlidableScrollActionPane(),
    'SlidableStrechActionPane': SlidableStrechActionPane(),
  };
  List<Slidable> _items;
  @override
  void initState() {
    super.initState();
    final mainActions = <Widget>[
      IconSlideAction(
        caption: 'Archive',
        color: Colors.blue,
        icon: Icons.archive,
        onTap: () => _showSnackBar('Archive'),
      ),
      IconSlideAction(
        caption: 'Share',
        color: Colors.indigo,
        icon: Icons.share,
        onTap: () => _showSnackBar('Share'),
        // Don't
        closeOnTap: false,
      ),
    ];
    final secondaryActions = <Widget>[
      IconSlideAction(
        caption: 'More',
        color: Colors.black45,
        icon: Icons.more_horiz,
        onTap: () => _showSnackBar('More'),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => _showSnackBar('Delete'),
      ),
    ];
    _items = [
      for (final entry in _kActionpaneTypes.entries)
        Slidable(
          actionPane: entry.value,
          actions: mainActions, // swipe right
          secondaryActions: secondaryActions, //swipe left
          child: ListTile(
            leading: const Icon(Icons.swipe),
            title: Text('ListTile with ${entry.key}'),
            subtitle: const Text('Swipe left and right to see the actions'),
          ),
        ),
    ];
    // Dismissible tile example:
    // First create a dismissal obj
    final dismissal = SlidableDismissal(
      onDismissed: (actionType) {
        _showSnackBar(actionType == SlideActionType.primary
            ? 'Dismiss Archive'
            : 'Dimiss Delete');
        setState(() => this._items.removeAt(_items.length - 1));
      },
      // Confirm on dismissal:
      onWillDismiss: (actionType) {
        return showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  actionType == SlideActionType.primary ? 'Archive' : 'Delete'),
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
      },
      child: const SlidableDrawerDismissal(),
    );
    // Set the `dismissal` argument to Slidable.
    _items.add(
      Slidable(
        dismissal: dismissal,
        key: const Key('dimissibleTile'),
        actionPane: const SlidableDrawerActionPane(),
        actions: [mainActions[0]], // 'Archive' action
        secondaryActions: [secondaryActions[1]], // 'Delete' action
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
