import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class RadarChartExample extends StatelessWidget {
  const RadarChartExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RadarChart(
      features: <String>["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH"],
      ticks: <int>[7, 14, 21, 28, 35],
      data: <List<int>>[
        [10, 20, 28, 5, 16, 15, 17, 6],
        [15, 1, 4, 14, 23, 10, 6, 19]
      ],
    );
  }
}
