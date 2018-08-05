import 'package:flutter/material.dart';
import '../my_route.dart';

class TabsExample extends MyRoute {
  const TabsExample([String sourceFile = 'lib/routes/nav_tabs_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Tabs';

  @override
  get links =>
      {'Doc': 'https://docs.flutter.io/flutter/material/TabBar-class.html'};

  @override
  Widget buildMyRouteContent(BuildContext context) {
    final _kTabPages = <Widget>[
      Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
      Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
      Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
    ];
    final _kTabs = <Tab>[
      Tab(icon: Icon(Icons.cloud), text: 'Tab1'),
      Tab(icon: Icon(Icons.alarm), text: 'Tab2'),
      Tab(icon: Icon(Icons.forum), text: 'Tab3'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('appbar title'),
          backgroundColor: Colors.cyan,
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}
