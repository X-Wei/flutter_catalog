import 'package:flutter/material.dart';
import '../my_route.dart';

class BottomTabbarExample extends MyRoute {
  const BottomTabbarExample(
      [String sourceFile = 'lib/routes/nav_bottom_tabbar_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Bottom tab bar';

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _BottomTabbarPage();
  }
}

class _BottomTabbarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomTabbarPageState();
}

class _BottomTabbarPageState extends State<_BottomTabbarPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  static const _kTabPages = <Widget>[
    Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
    Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
    Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
  ];
  static const _kTabs = <Tab>[
    Tab(icon: Icon(Icons.cloud), text: 'Tab1'),
    Tab(icon: Icon(Icons.alarm), text: 'Tab2'),
    Tab(icon: Icon(Icons.forum), text: 'Tab3'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: TabBarView(
        children: _kTabPages,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          tabs: _kTabs,
          controller: _tabController,
        ),
      ),
    );
  }
}
