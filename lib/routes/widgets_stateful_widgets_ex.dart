import 'package:flutter/material.dart';

class StatefulWidgetsExample extends StatefulWidget {
  const StatefulWidgetsExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatefulWidgetsExampleState();
}

class _StatefulWidgetsExampleState extends State<StatefulWidgetsExample> {
  bool _switchVal = true;
  bool _checkBoxVal = true;
  double _slider1Val = 0.5;
  double _slider2Val = 50.0;
  int _radioVal = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('Switch'),
        Center(
          child: Switch(
            onChanged: (bool value) {
              setState(() => this._switchVal = value);
            },
            value: this._switchVal,
          ),
        ),
        Text('Disabled Switch'),
        Center(
          child: Switch(
            onChanged: null,
            value: false,
          ),
        ),
        Divider(),
        Text('Checkbox'),
        Checkbox(
          onChanged: (bool value) {
            setState(() => this._checkBoxVal = value);
          },
          value: this._checkBoxVal,
        ),
        Text('Disabled Checkbox'),
        Checkbox(
          tristate: true,
          onChanged: null,
          value: null,
        ),
        Divider(),
        Text('Slider'),
        Slider(
          onChanged: (double value) {
            setState(() => this._slider1Val = value);
          },
          value: this._slider1Val,
        ),
        Text('Slider with Divisions and Label'),
        Slider(
            value: _slider2Val,
            min: 0.0,
            max: 100.0,
            divisions: 5,
            label: '${_slider2Val.round()}',
            onChanged: (double value) {
              setState(() => _slider2Val = value);
            }),
        Divider(),
        Text('LinearProgressIndicator'),
        // **When value=null, progress indicators become stateless.**
        LinearProgressIndicator(),
        Divider(),
        Text('CircularProgressIndicator'),
        Center(child: CircularProgressIndicator()),
        Divider(),
        Text('Radio'),
        Row(
          children: [0, 1, 2, 3]
              .map((int index) => Radio<int>(
                    value: index,
                    groupValue: this._radioVal,
                    onChanged: (int value) {
                      setState(() => this._radioVal = value);
                    },
                  ))
              .toList(),
        ),
        Divider(),
      ],
    );
  }
}
