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
        const Text('Switch'),
        Center(
          child: Switch(
            onChanged: (bool value) {
              setState(() => this._switchVal = value);
            },
            value: this._switchVal,
          ),
        ),
        const Text('Disabled Switch'),
        const Center(
          child: Switch(
            onChanged: null,
            value: false,
          ),
        ),
        const Divider(),
        const Text('Checkbox'),
        Checkbox(
          onChanged: (bool value) {
            setState(() => this._checkBoxVal = value);
          },
          value: this._checkBoxVal,
        ),
        const Text('Disabled Checkbox'),
        const Checkbox(
          tristate: true,
          onChanged: null,
          value: null,
        ),
        const Divider(),
        const Text('Slider'),
        Slider(
          onChanged: (double value) {
            setState(() => this._slider1Val = value);
          },
          value: this._slider1Val,
        ),
        const Text('Slider with Divisions and Label'),
        Slider(
            value: _slider2Val,
            max: 100.0,
            divisions: 5,
            label: '${_slider2Val.round()}',
            onChanged: (double value) {
              setState(() => _slider2Val = value);
            }),
        const Divider(),
        const Text('LinearProgressIndicator'),
        // **When value=null, progress indicators become stateless.**
        const LinearProgressIndicator(),
        const Divider(),
        const Text('CircularProgressIndicator'),
        const Center(child: CircularProgressIndicator()),
        const Divider(),
        const Text('Radio'),
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
        const Divider(),
      ],
    );
  }
}
