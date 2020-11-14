import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

/// !!Step1: prepare the data to plot.
final _data = <Tuple3<String, double, Color>>[
  Tuple3('housing', 1000, Colors.primaries[1]),
  Tuple3('food', 500, Colors.primaries[4]),
  Tuple3('health', 200, Colors.primaries[8]),
  Tuple3('trasport', 100, Colors.primaries[16]),
];

class FlPieChartExample extends StatefulWidget {
  const FlPieChartExample({Key key}) : super(key: key);

  @override
  _FlPieChartExampleState createState() => _FlPieChartExampleState();
}

class _FlPieChartExampleState extends State<FlPieChartExample> {
  int _touchedIdx = -1;
  bool _showBorder = true;
  double _radius = 100;
  double _innerRadius = 0;
  double _sectionsSpace = 0;
  double _startDegreeOffset = 180;

  @override
  Widget build(BuildContext context) {
    /// !!Step2: convert data into pieChartSectionData.
    final pieChartSections = <PieChartSectionData>[
      for (int i = 0; i < _data.length; ++i)
        PieChartSectionData(
          title: _data[i].item1,
          value: _data[i].item2,
          color: _data[i].item3,
          // Make selected section larger
          radius: i == _touchedIdx ? _radius * 1.2 : _radius,
        ),
    ];

    /// !!Step3: prepare pieChartData
    final pieChartData = PieChartData(
      sections: pieChartSections,
      // ! Touch behavior
      pieTouchData: PieTouchData(
        enabled: true,
        touchCallback: (pieTouchResponse) => setState(() {
          _touchedIdx = pieTouchResponse.touchedSectionIndex;
        }),
      ),
      centerSpaceRadius: _innerRadius,
      sectionsSpace: _sectionsSpace,
      startDegreeOffset: _startDegreeOffset,
      borderData: FlBorderData(show: _showBorder),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: PieChart(pieChartData),
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
          const ListTile(title: Text('Radius:')),
          Slider(
            divisions: 15,
            min: 50,
            max: 200,
            onChanged: (double val) => setState(() => this._radius = val),
            value: this._radius,
            label: '${this._radius}',
          ),
          const ListTile(title: Text('Inner circle radius:')),
          Slider(
            divisions: 10,
            max: 20,
            onChanged: (double val) => setState(() => this._innerRadius = val),
            value: this._innerRadius,
            label: '${this._innerRadius}',
          ),
          const ListTile(title: Text('Sections space:')),
          Slider(
            divisions: 10,
            max: 10,
            onChanged: (double val) =>
                setState(() => this._sectionsSpace = val),
            value: this._sectionsSpace,
            label: '${this._sectionsSpace}',
          ),
          const ListTile(title: Text('Start degree offset:')),
          Slider(
            max: 360,
            onChanged: (double val) =>
                setState(() => this._startDegreeOffset = val),
            value: this._startDegreeOffset,
            label: '${this._startDegreeOffset}',
          ),
        ],
      ),
    );
  }
}
