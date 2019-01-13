import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_route.dart';
import '../my_app_meta.dart'
    show
        BookmarkManager,
        kAboutRoute,
        kMyAppRoutesStructure,
        kRoutenameToRouteMap,
        kSharedPreferences,
        MyRouteGroup;

class MyHomeRoute extends MyRoute {
  const MyHomeRoute([String sourceFile = 'lib/routes/home.dart'])
      : super(sourceFile);

  @override
  get title => 'Flutter Catalog';

  @override
  get routeName => Navigator.defaultRouteName;

  @override
  Widget buildMyRouteContent(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    kSharedPreferences
      ..then((prefs) => setState(() => this._preferences = prefs));
  }

  @override
  Widget build(BuildContext context) {
    final listTiles = <Widget>[]
      ..add(_buildBookmarksExpansionTile())
      ..addAll(kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile))
      ..add(_myRouteToListTile(kAboutRoute, leading: Icon(Icons.info)));
    return ListView(children: listTiles);
  }

  Widget _buildBookmarksExpansionTile() {
    final List<Widget> routes =
        BookmarkManager.bookmarkedRoutenames(this._preferences)
            .map((routename) => kRoutenameToRouteMap[routename])
            .where((route) => route != null)
            .toList();
    MyRouteGroup staredGroup = MyRouteGroup(
      groupName: 'Bookmarks',
      icon: Icon(Icons.stars),
      routes: routes,
    );
    return _myRouteGroupToExpansionTile(staredGroup);
  }

  Widget _myRouteGroupToExpansionTile(MyRouteGroup myRouteGroup) {
    return Card(
      child: ExpansionTile(
        leading: myRouteGroup.icon,
        title: Text(
          myRouteGroup.groupName,
          style: Theme.of(context).textTheme.title,
        ),
        children: myRouteGroup.routes.map(this._myRouteToListTile).toList(),
      ),
    );
  }

  ListTile _myRouteToListTile(MyRoute myRoute,
      {Widget leading, IconData trialing: Icons.keyboard_arrow_right}) {
    final routeTitleTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold);
    return ListTile(
      leading: leading ?? MyRoute.of(context).starStatusOfRoute(myRoute),
      title: GestureDetector(
        child: Text(myRoute.title, style: routeTitleTextStyle),
      ),
      trailing: trialing == null ? null : Icon(trialing),
      subtitle: myRoute.description == null ? null : Text(myRoute.description),
      onTap: () => Navigator.of(context).pushNamed(myRoute.routeName),
    );
  }
}
