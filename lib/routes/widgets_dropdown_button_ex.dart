import 'package:flutter/material.dart';

// Inspired by dropdown buttons demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/buttons_demo.dart
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<StatefulWidget> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const menuItems = <String>[
    'One',
    'Two',
    'Three',
    'Four',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'One';
  String? _btn2SelectedVal;
  late String _btn3SelectedVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('DropDownButton with default:'),
          trailing: DropdownButton<String>(
            // Must be one of items.value.
            value: _btn1SelectedVal,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _btn1SelectedVal = newValue);
              }
            },
            items: this._dropDownMenuItems,
          ),
        ),
        ListTile(
          title: const Text('DropDownButton with hint:'),
          trailing: DropdownButton(
            value: _btn2SelectedVal,
            hint: const Text('Choose'),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => _btn2SelectedVal = newValue);
              }
            },
            items: _dropDownMenuItems,
          ),
        ),
        ListTile(
          title: const Text('Popup menu button:'),
          trailing: PopupMenuButton<String>(
            onSelected: (String newValue) {
              _btn3SelectedVal = newValue;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_btn3SelectedVal),
                ),
              );
            },
            itemBuilder: (BuildContext context) => _popUpMenuItems,
          ),
        ),
      ],
    );
  }
}

///! A helper class to show the UI of selecting value from a dropdown menu.
///! Used elsewhere in the flutter catalog app.(../../screenshots/value-picker-tile.png)
class MyValuePickerTile<T> extends StatelessWidget {
  final T val;
  final Iterable<T> values;
  final String title;
  final String Function(T)? getname;
  final Function(T) onChanged;

  const MyValuePickerTile({
    super.key,
    required this.val,
    required this.values,
    required this.title,
    required this.onChanged,
    this.getname,
  });

  @override
  Widget build(BuildContext context) {
    final dropDown = DropdownButton<T>(
      value: val,
      onChanged: (T? newval) {
        if (newval != null) onChanged(newval);
      },
      items: [
        for (final v in values)
          DropdownMenuItem<T>(
              value: v, child: Text(getname?.call(v) ?? v.toString()))
      ],
    );
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return isSmallScreen
        ? ListTile(
            title: Align(alignment: Alignment.centerRight, child: dropDown),
            subtitle:
                Align(alignment: Alignment.centerRight, child: Text(title)),
          )
        : ListTile(
            title: Text('$title :'),
            trailing: dropDown,
          );
  }
}
