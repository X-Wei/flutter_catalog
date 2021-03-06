import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'package:flutter_catalog/constants.dart';

// Inspired by the about page in Eajy's flutter demo:
// https://github.com/Eajy/flutter_demo/blob/master/lib/route/about.dart
class MyAboutRoute extends StatelessWidget {
  const MyAboutRoute({Key key}) : super(key: key);

  // These tiles are also used as drawer nav items in home route.
  static final List<Widget> kAboutListTiles = <Widget>[
    const ListTile(
      title: Text(APP_DESCRIPTION),
    ),
    const Divider(),
    ListTile(
      leading: const Icon(Icons.shop),
      title: const Text('Rate on Google Play'),
      onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
    ),
    ListTile(
      leading: const Icon(Icons.code),
      title: const Text('Source code on GitHub'),
      onTap: () => url_launcher.launch(GITHUB_URL),
    ),
    ListTile(
      leading: const Icon(Icons.bug_report),
      title: const Text('Report issue on GitHub'),
      onTap: () => url_launcher.launch('$GITHUB_URL/issues'),
    ),
    ListTile(
      leading: const Icon(Icons.open_in_new),
      title: const Text('Visit my website'),
      onTap: () => url_launcher.launch(AUTHOR_SITE),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final header = ListTile(
      leading: kAppIcon,
      title: const Text(APP_NAME),
      subtitle: const Text(APP_VERSION),
      trailing: IconButton(
        icon: const Icon(Icons.info),
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationIcon: kAppIcon,
              children: <Widget>[const Text(APP_DESCRIPTION)]);
        },
      ),
    );
    return ListView(
      children: <Widget>[
        header,
        ...kAboutListTiles,
      ],
    );
  }
}
