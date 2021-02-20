import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './my_app_routes.dart' show kAppRoutingTable;
import './my_app_settings.dart';
import './themes.dart';

class MyMainApp extends StatelessWidget {
  final SharedPreferences sharedPref;
  const MyMainApp(this.sharedPref, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyAppSettings>.value(
      value: MyAppSettings(sharedPref),
      child: const _MyMaterialApp(),
    );
  }
}

class _MyMaterialApp extends StatelessWidget {
  const _MyMaterialApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Catalog',
      theme: Provider.of<MyAppSettings>(context).isDarkMode
          ? kDarkTheme
          : kLightTheme,
      routes: kAppRoutingTable,
    );
  }
}
