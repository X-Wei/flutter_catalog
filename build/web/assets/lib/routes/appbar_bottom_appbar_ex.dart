import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Adapted from offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/bottom_app_bar_demo.dart
class BottomAppbarExample extends StatefulWidget {
  const BottomAppbarExample({Key key}) : super(key: key);

  @override
  _BottomAppbarExampleState createState() => _BottomAppbarExampleState();
}

class _BottomAppbarExampleState extends State<BottomAppbarExample> {
  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.endDocked;
  bool _isBottomBarNotched = false;
  bool _isFabMini = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Text('FloatingActionButton position:'),
            trailing: DropdownButton<FloatingActionButtonLocation>(
              value: this._fabLocation,
              onChanged: (FloatingActionButtonLocation newVal) {
                if (newVal != null) {
                  setState(() => this._fabLocation = newVal);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.centerFloat,
                  child: Text('centerFloat'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.endFloat,
                  child: Text('endFloat'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.centerDocked,
                  child: Text('centerDocked'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.endDocked,
                  child: Text('endDocked'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.miniStartTop,
                  child: Text('miniStartTop'),
                ),
                DropdownMenuItem(
                  value: FloatingActionButtonLocation.startTop,
                  child: Text('startTop'),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Mini FAB:'),
            trailing: Switch(
              value: this._isFabMini,
              onChanged: (bool val) {
                setState(() => this._isFabMini = val);
              },
            ),
          ),
          ListTile(
            title: const Text('BottomAppBar notch:'),
            trailing: Switch(
              value: this._isBottomBarNotched,
              onChanged: (bool val) {
                setState(() => this._isBottomBarNotched = val);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: this._isFabMini,
        onPressed: () =>
            Fluttertoast.showToast(msg: 'Dummy floating action button'),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: this._fabLocation,
      bottomNavigationBar: this._buildBottomAppBar(context),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: this._isBottomBarNotched ? const CircularNotchedRectangle() : null,
      color: Theme.of(context).primaryColor,
      child: Row(
        children: <Widget>[
          // Bottom that pops up from the bottom of the screen.
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => Container(
                alignment: Alignment.center,
                height: 200,
                child: const Text('Dummy bottom sheet'),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () =>
                Fluttertoast.showToast(msg: 'Dummy search action.'),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => Fluttertoast.showToast(msg: 'Dummy menu action.'),
          ),
        ],
      ),
    );
  }
}
