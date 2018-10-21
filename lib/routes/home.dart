import 'package:flutter/material.dart';
import '../my_route.dart';
import '../my_app_meta.dart' show kMyAppRoutesStructure, MyRouteGroup;

class MyHomeRoute extends MyRoute {
  const MyHomeRoute([String sourceFile = 'lib/routes/home.dart'])
      : super(sourceFile);

  @override
  get title => 'Flutter Catalog';

  @override
  get routeName =>
      Navigator.defaultRouteName; // Navigator.defaultRouteName is just "/".

  @override
  Widget buildMyRouteContent(BuildContext context) {
    ListTile _myRouteToListTile(MyRoute myRoute) {
      return ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        title: Text(myRoute.title),
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

    return ListView(
      children:
          kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile).toList(),
    );
  }
}
