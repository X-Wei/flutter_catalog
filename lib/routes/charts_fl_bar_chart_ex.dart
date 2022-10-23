import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// !!Step1: prepare the data to plot.
final _data1 = <double, double>{1: 9, 2: 12, 3: 10, 4: 20, 5: 14, 6: 18};
final _data2 = <double, double>{1: 8, 2: 15, 3: 17, 4: 11, 5: 13, 6: 20};

class FlBarChartExample extends StatefulWidget {
  const FlBarChartExample({super.key});

  @override
  _FlBarChartExampleState createState() => _FlBarChartExampleState();
}

class _FlBarChartExampleState extends State<FlBarChartExample> {
  bool _showBorder = true;
  bool _showGrid = false;

  @override
  Widget build(BuildContext context) {
    /// !!Step2: convert data into barGroups.
    final barGroups = <BarChartGroupData>[
      for (final entry in _data1.entries)
        BarChartGroupData(
          x: entry.key.toInt(),
          barRods: [
            BarChartRodData(toY: entry.value, color: Colors.blue),
            BarChartRodData(toY: _data2[entry.key]!, color: Colors.red),
          ],
        ),
    ];

    /// !!Step3: prepare barChartData
    final barChartData = BarChartData(
      maxY: 25,
      // ! The data to show
      barGroups: barGroups,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
        ),
      ),
      // ! Borders:
      borderData: FlBorderData(show: _showBorder),
      // ! Grid behavior:
      gridData: FlGridData(show: _showGrid),
      // ! Title and ticks in the axis
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          axisNameWidget: Text('Month'),
          sideTitles: SideTitles(
            showTitles: true,
            // ! Decides how to show bottom titles,
            // here we convert double to month names
            getTitlesWidget: (double val, _) =>
                Text(DateFormat.MMM().format(DateTime(2020, val.toInt()))),
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: Text('Sales'),
          sideTitles: SideTitles(
            showTitles: true,
            // ! Decides how to show left titles,
            // here we skip some values by returning ''.
            getTitlesWidget: (double val, _) {
              if (val.toInt() % 5 != 0) return Text('');
              return Text('${val.toInt()}');
            },
          ),
        ),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BarChart(barChartData),
      ),
      bottomNavigationBar: _buildControlWidgets(),
    );
  }

  Widget _buildControlWidgets() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: ListView(
        children: [
          SwitchListTile(
            title: const Text('ShowBorder'),
            onChanged: (bool val) => setState(() => this._showBorder = val),
            value: this._showBorder,
          ),
          SwitchListTile(
            title: const Text('ShowGrid'),
            onChanged: (bool val) => setState(() => this._showGrid = val),
            value: this._showGrid,
          ),
        ],
      ),
    );
  }
}
