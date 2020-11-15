import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';

class HeatmapCalendarExample extends StatelessWidget {
  const HeatmapCalendarExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! Note: the datetimes provided must have the hour/minute/second cleared:
    final today = TimeUtils.removeTime(DateTime.now());
    return Column(
      children: [
        Text(
          'Heatmap calendar',
          style: Theme.of(context).textTheme.headline4,
        ),
        HeatMapCalendar(
          // !! Prepare the data: mapping from dates and integers
          input: {
            today.subtract(const Duration(days: 1)): 40,
            today.subtract(const Duration(days: 2)): 30,
            today.subtract(const Duration(days: 3)): 10,
            today.subtract(const Duration(days: 5)): 30,
            today.subtract(const Duration(days: 7)): 15,
            today.subtract(const Duration(days: 10)): 5,
            today.subtract(const Duration(days: 14)): 10,
            today.subtract(const Duration(days: 28)): 5,
          },
          // ! Set color map.
          colorThresholds: {
            1: Colors.green[100],
            10: Colors.green[300],
            30: Colors.green[500],
          },
          squareSize: 18,
          textOpacity: 0.3,
          labelTextColor: Colors.blueGrey,
          dayTextColor: Colors.blue[500],
          // Week day and month labels can be overriden:
          // weekDaysLabels: const ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
          // monthsLabels: const ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          //    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        ),
        const Text('(Double tap to toggle dates text)'),
      ],
    );
  }
}
