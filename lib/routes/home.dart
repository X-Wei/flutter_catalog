import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_app_settings.dart';
import '../my_route.dart';
import '../my_app_routes.dart'
    show MyRouteGroup, kAboutRoute, kMyAppRoutesStructure;

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ListTile _myRouteToListTile(MyRoute myRoute,
        {Widget leading, IconData trialing: Icons.keyboard_arrow_right}) {
      final routeTitleTextStyle = Theme.of(context)
          .textTheme
          .body1
          .copyWith(fontWeight: FontWeight.bold);
      return ListTile(
        leading: leading ??
            Provider.of<MyAppSettings>(context)
                .starStatusOfRoute(myRoute.routeName),
        title: Text(myRoute.title, style: routeTitleTextStyle),
        trailing: trialing == null ? null : Icon(trialing),
        subtitle:
            myRoute.description == null ? null : Text(myRoute.description),
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

    Widget _buildBookmarksExpansionTile() {
      final settings = Provider.of<MyAppSettings>(context);
      MyRouteGroup starredGroup = MyRouteGroup(
        groupName: 'Bookmarks',
        icon: Icon(Icons.stars),
        routes: settings.starredRoutes,
      );
      return _myRouteGroupToExpansionTile(starredGroup);
    }

    return ListView(
      children: <Widget>[
        _buildBookmarksExpansionTile(),
        ...kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile),
        _myRouteToListTile(kAboutRoute, leading: Icon(Icons.info)),
      ],
    );
  }
}
