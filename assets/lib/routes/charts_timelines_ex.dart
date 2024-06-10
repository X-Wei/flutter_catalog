import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';

import 'widgets_dropdown_button_ex.dart';

class TimeLinesExample extends StatefulWidget {
  const TimeLinesExample({super.key});

  @override
  State<TimeLinesExample> createState() => _TimeLinesExampleState();
}

class _TimeLinesExampleState extends State<TimeLinesExample> {
  ContentsAlign _align = ContentsAlign.basic;
  IndicatorStyle _indicatorStyle = IndicatorStyle.dot;
  ConnectorStyle _connectorStyle = ConnectorStyle.solidLine;
  ConnectorStyle _endConnectorStyle = ConnectorStyle.solidLine;
  double _nodePos = 0.2;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        //! Similar to ListTile.builder(), we can also add tiles ourselves.
        Timeline.tileBuilder(
          shrinkWrap: true,
          builder: TimelineTileBuilder.fromStyle(
            itemCount: 5,
            contentsAlign: _align,
            indicatorStyle: _indicatorStyle,
            connectorStyle: _connectorStyle,
            // Main widget beside the timeline.
            contentsBuilder: (context, i) => Card(
              color: Colors.primaries[i % Colors.primaries.length],
              child: ListTile(title: Text('Event $i')),
            ),
            // Widget on the *opposite side* of the timeline.
            oppositeContentsBuilder: (_, i) => Text('index $i'),
            // Where the timeline node shall be at
            nodePositionBuilder: (context, index) => _nodePos,
          ),
        ),
        Divider(),
        _buildControlTiles(),
      ],
    );
  }

  Widget _buildControlTiles() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("NodePosition:"),
        Slider(
          value: _nodePos,
          min: 0.0,
          max: 1.0,
          onChanged: (val) => setState(() => _nodePos = val),
        ),
        MyValuePickerTile<ContentsAlign>(
          val: _align,
          values: ContentsAlign.values,
          title: 'ContentAlignment',
          onChanged: (val) => setState(() => _align = val),
        ),
        MyValuePickerTile<IndicatorStyle>(
          val: _indicatorStyle,
          values: IndicatorStyle.values,
          title: 'IndicatorStyle',
          onChanged: (val) => setState(() => _indicatorStyle = val),
        ),
        MyValuePickerTile<ConnectorStyle>(
          val: _connectorStyle,
          values: ConnectorStyle.values,
          title: 'ConnectorStyle',
          onChanged: (val) => setState(() => _connectorStyle = val),
        ),
        MyValuePickerTile<ConnectorStyle>(
          val: _endConnectorStyle,
          values: ConnectorStyle.values,
          title: 'EndConnectorStyle',
          onChanged: (val) => setState(() => _endConnectorStyle = val),
        ),
      ],
    );
  }
}
