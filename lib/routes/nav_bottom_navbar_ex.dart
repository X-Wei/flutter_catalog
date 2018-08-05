import 'package:flutter/material.dart';
import '../my_route.dart';

class BottomNavigationBarExample extends MyRoute {
  const BottomNavigationBarExample(
      [String sourceFile = 'lib/routes/nav_bottom_navbar_ex.dart'])
      : super(sourceFile);

  @override
  get title => 'Bottom navigation bar';

  @override
  get links => {
        'Doc':
            'https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html',
      };

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return _BottomNavDemo();
  }
}

class _BottomNavDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<_BottomNavDemo> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Center(child: Icon(Icons.cloud, size: 64.0, color: Colors.teal)),
      Center(child: Icon(Icons.alarm, size: 64.0, color: Colors.cyan)),
      Center(child: Icon(Icons.forum, size: 64.0, color: Colors.blue)),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.cloud), title: Text('Tab1')),
      BottomNavigationBarItem(icon: Icon(Icons.alarm), title: Text('Tab2')),
      BottomNavigationBarItem(icon: Icon(Icons.forum), title: Text('Tab3')),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
