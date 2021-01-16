import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_app_routes.dart';
import 'package:provider/provider.dart';

import './my_app_routes.dart'
    show MyRouteGroup, kAboutRoute, kMyAppRoutesBasic, kMyAppRoutesAdvanced;
import './my_app_settings.dart';
import './my_route.dart';

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
      label: 'Basics',
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blueAccent,
      icon: Icon(Icons.insert_chart),
      label: 'Advanced',
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.indigo,
      icon: Icon(Icons.star),
      label: 'Bookmarks',
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
        _myRouteToListTile(route, leading: const Icon(Icons.bookmark)),
      _myRouteToListTile(kAboutRoute, leading: const Icon(Icons.info)),
    ];
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: <Widget>[
          ListView(children: basicDemos),
          ListView(children: advancedDemos),
          ListView(children: bookmarkAndAboutDemos),
        ],
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

  Widget _myRouteToListTile(MyRoute myRoute,
      {Widget leading, IconData trialing = Icons.keyboard_arrow_right}) {
    final mySettings = context.watch<MyAppSettings>();
    final routeTitleTextStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontWeight: FontWeight.bold);
    final leadingWidget =
        leading ?? mySettings.starStatusOfRoute(myRoute.routeName);
    final isNew = mySettings.isNewRoute(myRoute.routeName);
    return ListTile(
      leading: isNew
          ? Badge(
              position: BadgePosition.topEnd(top: 2, end: 2),
              child: leadingWidget,
            )
          : leadingWidget,
      title: Text(myRoute.title, style: routeTitleTextStyle),
      trailing: trialing == null ? null : Icon(trialing),
      subtitle: myRoute.description == null ? null : Text(myRoute.description),
      onTap: () {
        if (isNew) {
          mySettings.markRouteKnown(myRoute.routeName);
        }
        Navigator.of(context).pushNamed(myRoute.routeName);
      },
    );
  }

  Widget _myRouteGroupToExpansionTile(MyRouteGroup myRouteGroup) {
    final nNew = context.watch<MyAppSettings>().numNewRoutes(myRouteGroup);
    return Card(
      child: ExpansionTile(
        leading: nNew > 0
            ? Badge(badgeContent: Text('$nNew'), child: myRouteGroup.icon)
            : myRouteGroup.icon,
        title: Text(
          myRouteGroup.groupName,
          style: Theme.of(context).textTheme.headline6,
        ),
        children: myRouteGroup.routes.map(_myRouteToListTile).toList(),
      ),
    );
  }
}
