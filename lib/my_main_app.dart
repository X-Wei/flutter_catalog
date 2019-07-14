import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './my_app_meta.dart' as my_app_meta;
import './themes.dart';
import './routes/about.dart';
import './routes/home.dart';

const _kHomeRoute = MyHomeRoute();
const _kAboutRoute = MyAboutRoute();

class MyMainApp extends StatelessWidget {
  const MyMainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: FlutterLogo());
        }
        final SharedPreferences preferences = snapshot.data;
        final darkTheme = preferences.getBool('DARK_THEME') ?? false;
        // The app's root-level routing table.
        final Map<String, WidgetBuilder> _routingTable = {
          Navigator.defaultRouteName: (context) => _kHomeRoute,
          _kAboutRoute.routeName: (context) => _kAboutRoute,
          for (var route in my_app_meta.kAllRoutes)
            route.routeName: (context) => route
        };
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
