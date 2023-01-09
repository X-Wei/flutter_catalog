import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class NewHeatmapCalendarExample extends StatefulWidget {
  const NewHeatmapCalendarExample({super.key});

  @override
  State<NewHeatmapCalendarExample> createState() =>
      _NewHeatmapCalendarExampleState();
}

// Strip the hour/minute/second from datetime
DateTime _removeHMS(DateTime d) => DateTime(d.year, d.month, d.day);

// ! The display data for the hetamap.
Map<DateTime, int> _genDummyDateset() {
  final today = _removeHMS(DateTime.now());
  return {
    today.subtract(const Duration(days: 1)): 40,
    today.subtract(const Duration(days: 2)): 30,
    today.subtract(const Duration(days: 3)): 10,
    today.subtract(const Duration(days: 5)): 25,
    today.subtract(const Duration(days: 7)): 15,
    today.subtract(const Duration(days: 10)): 5,
    today.subtract(const Duration(days: 14)): 10,
    today.subtract(const Duration(days: 28)): 5,
  };
}

class _NewHeatmapCalendarExampleState extends State<NewHeatmapCalendarExample> {
  ColorMode _colorMode = ColorMode.color;
  bool _showText = false;
  bool _scrollable = true;
  bool _showColorTip = false;
  double _size = 20;

  static const kColorMap = {
    1: Colors.red,
    3: Colors.orange,
    5: Colors.yellow,
    10: Colors.green,
    15: Colors.blue,
    20: Colors.indigo,
    30: Colors.purple,
  };
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeatMap(
          datasets: _genDummyDateset(),
          startDate: null, // default=today-1year
          endDate: null, // default=today
          size: _size,
          colorMode: _colorMode,
          showText: _showText,
          scrollable: _scrollable,
          showColorTip: _showColorTip,
          colorsets: kColorMap,
          onClick: (date) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(content: Text(date.toString())));
          },
        ),
        Divider(),
        ..._controlWidgets(),
      ],
    );
  }

  /// Widgets to configure the heatmap
  List<Widget> _controlWidgets() => <Widget>[
        SwitchListTile(
          title: const Text('showText:'),
          onChanged: (bool val) => setState(() => this._showText = val),
          value: this._showText,
        ),
        SwitchListTile(
          title: const Text('scrollable:'),
          onChanged: (bool val) => setState(() => this._scrollable = val),
          value: this._scrollable,
        ),
        SwitchListTile(
          title: const Text('showColorTip:'),
          onChanged: (bool val) => setState(() => this._showColorTip = val),
          value: this._showColorTip,
        ),
        ListTile(
          title: Text('size (of each block): $_size'),
          subtitle: Slider(
              min: 10,
              max: 50,
              divisions: 8,
              label: _size.toString(),
              value: _size,
              onChanged: (v) => setState(() => this._size = v)),
        ),
        ListTile(
          title: const Text('colorMode:'),
          trailing: DropdownButton<ColorMode>(
            value: this._colorMode,
            onChanged: (ColorMode? newVal) {
              if (newVal != null) setState(() => this._colorMode = newVal);
            },
            items: [
              for (final val in ColorMode.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
      ];
}
