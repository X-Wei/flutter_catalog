import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Data class to visualize.
class _CostsData {
  final String category;
  final int cost;

  const _CostsData(this.category, this.cost);
}

class PieChartExample extends StatefulWidget {
  const PieChartExample({Key key}) : super(key: key);

  @override
  _PieChartExampleState createState() => _PieChartExampleState();
}

class _PieChartExampleState extends State<PieChartExample> {
  // Chart configs.
  bool _animate = true;
  bool _defaultInteractions = true;
  double _arcRatio = 0.8;
  charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
  charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
  charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.bottom;

  // Data to render.
  List<_CostsData> _data = [
    _CostsData('housing', 1000),
    _CostsData('food', 500),
    _CostsData('health', 200),
    _CostsData('trasport', 100),
  ];

  @override
  Widget build(BuildContext context) {
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(this._data.length);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 300,
          child: charts.PieChart(
            // Pie chart can only render one series.
            /*seriesList=*/ [
              charts.Series<_CostsData, String>(
                id: 'Sales-1',
                colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
                domainFn: (_CostsData sales, _) => sales.category,
                measureFn: (_CostsData sales, _) => sales.cost,
                data: this._data,
                // Set a label accessor to control the text of the arc label.
                labelAccessorFn: (_CostsData row, _) =>
                    '${row.category}: ${row.cost}',
              ),
            ],
            animate: this._animate,
            defaultRenderer: new charts.ArcRendererConfig(
              arcRatio: this._arcRatio,
              arcRendererDecorators: [
                charts.ArcLabelDecorator(labelPosition: this._arcLabelPosition)
              ],
            ),
            behaviors: [
              // Add title.
              charts.ChartTitle(
                'Dummy costs breakup',
                behaviorPosition: this._titlePosition,
              ),
              // Add legend. ("Datum" means the "X-axis" of each data point.)
              charts.DatumLegend(
                position: this._legendPosition,
                desiredMaxRows: 2,
              ),
            ],
          ),
        ),
        Divider(),
        ..._controlWidgets(),
      ],
    );
  }

  /// Widgets to control the chart appearance and behavior.
  List<Widget> _controlWidgets() => <Widget>[
        SwitchListTile(
          title: Text('animate'),
          onChanged: (bool val) => setState(() => this._animate = val),
          value: this._animate,
        ),
        SwitchListTile(
          title: Text('defaultInteractions'),
          onChanged: (bool val) =>
              setState(() => this._defaultInteractions = val),
          value: this._defaultInteractions,
        ),
        ListTile(title: Text('Arc width ratio w.r.t. radius:')),
        Slider(
          divisions: 10,
          onChanged: (double val) => setState(() => this._arcRatio = val),
          value: this._arcRatio,
          label: '${this._arcRatio}',
        ),
        ListTile(
          title: Text('arcLabelPosition:'),
          trailing: DropdownButton<charts.ArcLabelPosition>(
            value: this._arcLabelPosition,
            onChanged: (charts.ArcLabelPosition newVal) {
              if (newVal != null) {
                setState(() => this._arcLabelPosition = newVal);
              }
            },
            items: [
              for (final val in charts.ArcLabelPosition.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
        ListTile(
          title: Text('titlePosition:'),
          trailing: DropdownButton<charts.BehaviorPosition>(
            value: this._titlePosition,
            onChanged: (charts.BehaviorPosition newVal) {
              if (newVal != null) {
                setState(() => this._titlePosition = newVal);
              }
            },
            items: [
              for (final val in charts.BehaviorPosition.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
        ListTile(
          title: Text('legendPosition:'),
          trailing: DropdownButton<charts.BehaviorPosition>(
            value: this._legendPosition,
            onChanged: (charts.BehaviorPosition newVal) {
              if (newVal != null) {
                setState(() => this._legendPosition = newVal);
              }
            },
            items: [
              for (final val in charts.BehaviorPosition.values)
                DropdownMenuItem(value: val, child: Text('$val'))
            ],
          ),
        ),
      ];
}
