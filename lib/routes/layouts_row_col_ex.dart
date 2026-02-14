import 'package:flutter/material.dart';

import 'widgets_dropdown_button_ex.dart';

// Inspired by bizz84's layout demo:
// https://github.com/bizz84/layout-demo-flutter
class RowColExample extends StatefulWidget {
  const RowColExample({super.key});
  @override
  _RowColExampleState createState() => _RowColExampleState();
}

class _RowColExampleState extends State<RowColExample> {
  static const kElements = <Widget>[
    Icon(Icons.stars, size: 50.0),
    Icon(Icons.stars, size: 100.0),
    Icon(Icons.stars, size: 50.0),
  ];

  bool _isRow = true;
  MainAxisSize _mainAxisSize = MainAxisSize.max;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.start;

  @override
  Widget build(BuildContext context) {
    final _appbarButtons = _getBottomBar();
    return Scaffold(body: _buildBody(), bottomNavigationBar: _appbarButtons);
  }

  Widget _buildBody() => Container(
    color: Colors.yellow,
    child: _isRow
        ? Row(
            mainAxisAlignment: _mainAxisAlignment,
            crossAxisAlignment: _crossAxisAlignment,
            mainAxisSize: _mainAxisSize,
            children: kElements,
          )
        : Column(
            mainAxisAlignment: _mainAxisAlignment,
            crossAxisAlignment: _crossAxisAlignment,
            mainAxisSize: _mainAxisSize,
            children: kElements,
          ),
  );

  Widget _getBottomBar() {
    return Material(
      color: Theme.of(context).primaryColorLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              RadioGroup<bool>(
                groupValue: this._isRow,
                onChanged: (bool? value) {
                  if (value != null) setState(() => this._isRow = value);
                },
                child: Row(
                  children: <Widget>[
                    Radio<bool>(value: true),
                    const Text('Row'),
                    Radio<bool>(value: false),
                    const Text('Column'),
                  ],
                ),
              ),
            ],
          ),
          MyValuePickerTile<MainAxisSize>(
            val: this._mainAxisSize,
            values: MainAxisSize.values,
            title: 'mainAxisSize: ',
            onChanged: (MainAxisSize newVal) {
              setState(() => _mainAxisSize = newVal);
            },
          ),
          MyValuePickerTile<MainAxisAlignment>(
            val: this._mainAxisAlignment,
            values: MainAxisAlignment.values,
            title: 'mainAxisAlignment: ',
            onChanged: (MainAxisAlignment newVal) {
              setState(() => _mainAxisAlignment = newVal);
            },
          ),
          MyValuePickerTile<CrossAxisAlignment>(
            val: this._crossAxisAlignment,
            values: CrossAxisAlignment.values,
            title: 'crossAxisAlignment: ',
            onChanged: (CrossAxisAlignment newVal) {
              setState(() => _crossAxisAlignment = newVal);
            },
          ),
        ],
      ),
    );
  }
}
