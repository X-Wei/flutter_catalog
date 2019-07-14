import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './my_app_meta.dart' as my_app_meta;
import './my_route.dart';
import './themes.dart';
import './routes/about.dart';
import './routes/home.dart';

const _kHomeRoute = MyHomeRoute();
const _kAboutRoute = MyAboutRoute();

class MyMainApp extends StatelessWidget {
  const MyMainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _allRoutes = my_app_meta.kMyAppRoutesStructure.expand((group) => group.routes);
    // Mapping route names to routes.
    final Map<String, MyRoute> kRoutenameToRouteMap = {
      Navigator.defaultRouteName: _kHomeRoute,
      _kAboutRoute.routeName: _kAboutRoute,
      for (var route in _allRoutes) route.routeName: route
    };

    // The app's root-level routing table.
    Map<String, WidgetBuilder> _routingTable = kRoutenameToRouteMap.map(
      (routeName, route) {
        final widgetBuilder = (BuildContext context) => route;
        return MapEntry<String, WidgetBuilder>(routeName, widgetBuilder);
      },
    );
    
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: FlutterLogo());
          }
          final SharedPreferences preferences = snapshot.data;
          final darkTheme = preferences.getBool('DARK_THEME') ?? false;
          return MaterialApp(
            title: 'Flutter Catalog',
            theme: darkTheme ? kDartTheme : kLightTheme,
            // No need to set `home` because `routes` is set to a routing table, and
            // Navigator.defaultRouteName ('/') has an entry in it.
            routes: _routingTable,
          );
        },
      );
  }
}