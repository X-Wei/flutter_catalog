import 'package:flutter/material.dart';
import './my_app_meta.dart' as my_app_meta;

void main() => runApp(
      MaterialApp(
        title: 'Flutter Catalog',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: my_app_meta.kHomeRouteName,
        // No need to set `home` because `routes` is set, in which initialRoute
        // and Navigator.defaultRouteName has an entry.
        routes: my_app_meta.kRoutingTable,
      ),
    );
