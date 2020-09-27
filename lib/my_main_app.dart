import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './constants.dart' show kAppIcon;
import './my_app_routes.dart' show kAppRoutingTable;
import './my_app_settings.dart';
import './themes.dart';

class MyMainApp extends StatefulWidget {
  const MyMainApp({Key key}) : super(key: key);

  @override
  _MyMainAppState createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  Future<SharedPreferences> _initAppFuture;

  @override
  void initState() {
    super.initState();
    Future<SharedPreferences> initApp() async {
      await Firebase.initializeApp();
      return await SharedPreferences.getInstance();
    }

    this._initAppFuture = initApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: this._initAppFuture,
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return _MySplashScreen();
        }
        return ChangeNotifierProvider<MyAppSettings>.value(
          value: MyAppSettings(snapshot.data),
          child: _MyMainApp(),
        );
      },
    );
  }
}

class _MySplashScreen extends StatelessWidget {
  const _MySplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.white,
      child: Center(child: kAppIcon),
    );
  }
}

class _MyMainApp extends StatelessWidget {
  const _MyMainApp({Key key}) : super(key: key);

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
