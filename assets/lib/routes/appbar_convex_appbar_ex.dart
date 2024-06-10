import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'widgets_dropdown_button_ex.dart';

const _kPages = <String, IconData>{
  'home': Icons.home,
  'map': Icons.map,
  'add': Icons.add,
  'message': Icons.message,
  'people': Icons.people,
};

class ConvexAppExample extends StatefulWidget {
  const ConvexAppExample({super.key});

  @override
  _ConvexAppExampleState createState() => _ConvexAppExampleState();
}

class _ConvexAppExampleState extends State<ConvexAppExample> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
        body: Column(
          children: [
            MyValuePickerTile<TabStyle>(
              val: _tabStyle,
              values: TabStyle.values,
              title: 'appbar style:',
              onChanged: (newStyle) {
                setState(() => _tabStyle = newStyle);
              },
            ),
            const Divider(),
            Expanded(
              child: TabBarView(
                children: [
                  for (final icon in _kPages.values) Icon(icon, size: 64),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          // Optional badge argument: keys are tab indices, values can be
          // String, IconData, Color or Widget.
          /*badge=*/ const <int, dynamic>{3: '99+'},
          style: _tabStyle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
      ),
    );
  }
}
