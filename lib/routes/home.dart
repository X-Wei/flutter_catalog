import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../my_route.dart';
import '../my_app_meta.dart'
    show kMyAppRoutesStructure, MyRouteGroup, kAboutRoute;

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
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() => this._preferences = prefs);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children:
            kMyAppRoutesStructure.map(_myRouteGroupToExpansionTile).toList()
              ..add(
                _myRouteToListTile(
                  kAboutRoute,
                  leading: Icon(Icons.info),
                  trialing: null,
                ),
              ),
      ),
    );
  }

  ListTile _myRouteToListTile(MyRoute myRoute,
      {Widget leading, IconData trialing: Icons.keyboard_arrow_right}) {
    final routeTitleTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontWeight: FontWeight.bold);
    return ListTile(
      leading: leading,
      title: GestureDetector(
        child: Text(myRoute.title, style: routeTitleTextStyle),
        // onTap: () => Navigator.of(context).pushNamed(myRoute.routeName),
      ),
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
        children: myRouteGroup.routes
            .map((route) => _myRouteToListTile(
                  route,
                  leading: IconButton(
                    icon: route.isStared(this._preferences)
                        ? Icon(Icons.star,
                            color: Theme.of(context).primaryColor)
                        : Icon(Icons.star_border),
                    onPressed: () =>
                        setState(() => route.toggleStared(this._preferences)),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
