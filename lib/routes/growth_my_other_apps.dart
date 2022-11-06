import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyOtherAppsExample extends StatelessWidget {
  const MyOtherAppsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Divider(),
        Card(
          child: Column(
            children: [
              ListTile(
                  leading: Image.asset('res/images/xydocs-flutter-icon.png'),
                  title: Text('Flutter Cookbook'),
                  subtitle:
                      Text('Official Flutter cookbooks, for offline reading.')),
              ListTile(
                title: Text('Watch Youtube video'),
                leading: Icon(CommunityMaterialIcons.youtube),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(
                  Uri.parse('https://www.youtube.com/watch?v=R8q-seYhUkY'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('View in store'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(
                  Uri.parse(Platform.isIOS
                      ? 'https://apps.apple.com/app/id1605475549'
                      : 'https://play.google.com/store/apps/details?id=io.github.xydocs.flutter_offline_doc'),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Image.asset('res/images/xydocs-cpp-icon.png'),
                title: Text('C++ Tip of the Week'),
                subtitle: Text('C++ best practices from Google.'),
              ),
              ListTile(
                title: Text('Watch Youtube video'),
                leading: Icon(CommunityMaterialIcons.youtube),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(
                  Uri.parse('https://www.youtube.com/watch?v=i97c4d0Gaz8'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('View in store'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(
                  Uri.parse(Platform.isIOS
                      ? 'https://apps.apple.com/us/app/c-tip-of-the-week/id1617459992'
                      : 'https://play.google.com/store/apps/details?id=io.github.xydocs.cpp_offline_doc'),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Image.asset('res/images/xymemo-icon.png'),
                title: Text('XYmemo'),
                subtitle: Text('Learn German vocabulary (in beta).'),
              ),
              ListTile(
                leading: Icon(Icons.shop),
                title: Text('View in store'),
                trailing: Icon(Icons.open_in_new),
                onTap: () => launchUrl(
                  Uri.parse(Platform.isIOS
                      ? 'https://apps.apple.com/us/developer/xing-wei/id1582381134'
                      : 'https://play.google.com/store/apps/details?id=io.github.x_wei.xymemo'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
