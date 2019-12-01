import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Data class to visualize.
class _SalesData {
  final int year;
  final int sales;

  _SalesData(this.year, this.sales);
  // Returns Jan.1st of that year as date.
  DateTime get date => DateTime(this.year, 1, 1);
}

/// Generate some random data.
List<_SalesData> _genRandData() {
  final random = Random();
  // Returns an increasing series with some fluctuations.
  return [
    for (int i = 2005; i < 2020; ++i)
      _SalesData(i, (i - 2000) * 40 + random.nextInt(100)),
  ];
}

class TimeseriesChartExample extends StatefulWidget {
  const TimeseriesChartExample({Key key}) : super(key: key);

  @override
  _TimeseriesChartExampleState createState() =>
      _TimeseriesChartExampleState();
}

class _TimeseriesChartExampleState extends State<TimeseriesChartExample> {
  // Chart configs.
  bool _animate = false;
  bool _defaultInteractions = true;
  bool _includeArea = true;
  bool _includePoints = true;
  bool _stacked = true;

  // Data to render.
  List<_SalesData> _series1, _series2;

  @override
  void initState() {
    super.initState();
    this._series1 = _genRandData();
    this._series2 = _genRandData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Container(
          height: 300,
          child: charts.TimeSeriesChart(
            /*seriesList=*/ [
              charts.Series<_SalesData, DateTime>(
                id: 'Sales-1',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (_SalesData sales, _) => sales.date,
                measureFn: (_SalesData sales, _) => sales.sales,
                data: this._series1,
              ),
              charts.Series<_SalesData, DateTime>(
                id: 'Sales-2',
                colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                domainFn: (_SalesData sales, _) => sales.date,
                measureFn: (_SalesData sales, _) => sales.sales,
                data: this._series2,
              ),
            ],
            defaultInteractions: this._defaultInteractions,
            defaultRenderer: charts.LineRendererConfig(
              includePoints: this._includePoints,
              includeArea: this._includeArea,
              stacked: this._stacked,
            ),
            animate: this._animate,
            behaviors: [
              // Add title.
              charts.ChartTitle('Dummy sales time series'),
              // Add legend.
              charts.SeriesLegend(),
              // Highlight X and Y value of selected point.
              charts.LinePointHighlighter(
                showHorizontalFollowLine:
                    charts.LinePointHighlighterFollowLineType.all,
                showVerticalFollowLine:
                    charts.LinePointHighlighterFollowLineType.nearest,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
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
        SwitchListTile(
          title: Text('includePoints'),
          onChanged: (bool val) => setState(() => this._includePoints = val),
          value: this._includePoints,
        ),
        SwitchListTile(
          title: Text('includeArea'),
          onChanged: (bool val) => setState(() => this._includeArea = val),
          value: this._includeArea,
        ),
        SwitchListTile(
          title: Text('stacked'),
          onChanged: (bool val) => setState(() => this._stacked = val),
          value: this._stacked,
        ),
      ],
    );
  }
}
