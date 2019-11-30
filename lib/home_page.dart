import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_app_routes.dart';
import 'package:provider/provider.dart';

import './my_app_settings.dart';
import './my_route.dart';
import './my_app_routes.dart'
    show MyRouteGroup, kAboutRoute, kMyAppRoutesBasic, kMyAppRoutesAdvanced;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _kBottmonNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.library_books),
      title: Text('Basics'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blueAccent,
      icon: Icon(Icons.insert_chart),
      title: Text('Advanced'),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.indigo,
      icon: Icon(Icons.star),
      title: Text('Bookmarks'),
    ),
  ];

  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final basicDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesBasic)
        _myRouteGroupToExpansionTile(group),
    ];
    final advancedDemos = <Widget>[
      for (final MyRouteGroup group in kMyAppRoutesAdvanced)
        _myRouteGroupToExpansionTile(group),
    ];
    final bookmarkAndAboutDemos = <Widget>[
      for (final MyRoute route
          in Provider.of<MyAppSettings>(context).starredRoutes)
        _myRouteToListTile(route, leading: Icon(Icons.bookmark)),
      _myRouteToListTile(kAboutRoute, leading: Icon(Icons.info)),
    ];
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          ListView(children: basicDemos),
          ListView(children: advancedDemos),
          ListView(children: bookmarkAndAboutDemos),
        ],
        index: _currentTabIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _kBottmonNavBarItems,
        currentIndex: _currentTabIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          setState(() => this._currentTabIndex = index);
        },
      ),
    );
  }

  ListTile _myRouteToListTile(MyRoute myRoute,
      {Widget leading, IconData trialing: Icons.keyboard_arrow_right}) {
    final routeTitleTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold);
    return ListTile(
      leading: leading ??
          Provider.of<MyAppSettings>(context)
              .starStatusOfRoute(myRoute.routeName),
      title: Text(myRoute.title, style: routeTitleTextStyle),
      trailing: trialing == null ? null : Icon(trialing),
      subtitle: myRoute.description == null ? null : Text(myRoute.description),
      onTap: () => Navigator.of(context).pushNamed(myRoute.routeName),
    );
  }

  Widget _myRouteGroupToExpansionTile(MyRouteGroup myRouteGroup) {
    return Card(
      child: ExpansionTile(
        leading: myRouteGroup.icon,
        title: Text(
          myRouteGroup.groupName,
          style: Theme.of(context).textTheme.title,
        ),
        children: myRouteGroup.routes.map(_myRouteToListTile).toList(),
      ),
    );
  }
}
